/**
 * Copyright (c) 2005-2011 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Eclipse Public License (EPL).
 * Please see the license.txt included with this distribution for details.
 * Any modifications to this file must keep this entire header intact.
 */
/*
 * Created on 08/08/2005
 */
package org.python.pydev.ui.pythonpathconf;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.eclipse.jface.viewers.ArrayContentProvider;
import org.eclipse.jface.viewers.LabelProvider;
import org.eclipse.swt.graphics.Image;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.ui.dialogs.ListDialog;
import org.python.pydev.core.IInterpreterManager;
import org.python.pydev.core.log.Log;
import org.python.pydev.editor.actions.PyAction;
import org.python.pydev.plugin.PydevPlugin;
import org.python.pydev.ui.UIConstants;

import at.jta.Key;
import at.jta.Regor;

import com.aptana.shared_core.structure.Tuple;
import com.aptana.shared_core.utils.PlatformUtils;

public class PythonInterpreterEditor extends AbstractInterpreterEditor {

    public PythonInterpreterEditor(String labelText, Composite parent, IInterpreterManager interpreterManager) {
        super(IInterpreterManager.PYTHON_INTERPRETER_PATH, labelText, parent, interpreterManager);
    }

    @Override
    public String[] getInterpreterFilterExtensions() {
        if (PlatformUtils.isWindowsPlatform()) {
            return new String[] { "*.exe", "*.*" };
        }
        return null;
    }

    @Override
    protected Tuple<String, String> getAutoNewInput() throws CancelException {
        List<String> pathsToSearch = new ArrayList<String>();
        if (!PlatformUtils.isWindowsPlatform()) {
            pathsToSearch.add("/usr/bin");
            pathsToSearch.add("/usr/local/bin");
            Tuple<String, String> ret = super.getAutoNewInputFromPaths(pathsToSearch, "python", "python");
            if (ret != null) {
                return ret;
            }
        } else {
            //On windows we can try to see the installed versions...
            List<File> foundVersions = new ArrayList<File>();
            try {
                Regor regor = new Regor();

                //The structure for Python is something as Software\\Python\\PythonCore\\2.6\\InstallPath
                for (Key root : new Key[] { Regor.HKEY_LOCAL_MACHINE, Regor.HKEY_CURRENT_USER }) {
                    Key key = regor.openKey(root, "Software\\Python\\PythonCore", Regor.KEY_READ);
                    if (key != null) {
                        try {
                            List l = regor.listKeys(key);
                            for (Object o : l) {
                                Key openKey = regor.openKey(key, (String) o + "\\InstallPath", Regor.KEY_READ);
                                if (openKey != null) {
                                    try {
                                        byte buf[] = regor.readValue(openKey, "");
                                        if (buf != null) {
                                            String parseValue = Regor.parseValue(buf);
                                            //Ok, this should be the directory where it's installed, try to find a 'python.exe' there...
                                            File file = new File(parseValue, "python.exe");
                                            if (file.isFile()&&file.exists()) {
                                                foundVersions.add(file);
                                            }
                                        }
                                    } finally {
                                        regor.closeKey(openKey);
                                    }
                                }
                            }
                        } finally {
                            regor.closeKey(key);
                        }
                    }
                    try {
                        foundPythonByCMD(foundVersions, root);
                    } catch (Exception e) {
                        //do nothing
                    }
                }

            } catch (Throwable e) {
                Log.log(e);
            }
            if (foundVersions.size() == 1) {
                return new Tuple<String, String>(getUniqueInterpreterName("python"), foundVersions.get(0).toString());
            }
            if (foundVersions.size() > 1) {
                //The user should select which one to use...
                ListDialog listDialog = new ListDialog(PyAction.getShell());

                listDialog.setContentProvider(new ArrayContentProvider());
                listDialog.setLabelProvider(new LabelProvider() {
                    @Override
                    public Image getImage(Object element) {
                        return PydevPlugin.getImageCache().get(UIConstants.PY_INTERPRETER_ICON);
                    }
                });
                listDialog.setInput(foundVersions.toArray());
                listDialog
                        .setMessage("Multiple interpreters were found installed.\nPlease select which one you want to configure.");

                int open = listDialog.open();
                if (open != ListDialog.OK) {
                    throw cancelException;
                }
                Object[] result = listDialog.getResult();
                if (result == null || result.length == 0) {
                    throw cancelException;
                }
                return new Tuple<String, String>(getUniqueInterpreterName("python"), result[0].toString());

            }
        }

        return new Tuple<String, String>(getUniqueInterpreterName("python"), "python"); //This should be enough to find it from the PATH or any other way it's defined.
    }

    /**
     * @param foundVersions
     * @param root
     * @throws IOException
     * @throws UnsupportedEncodingException
     */
    protected void foundPythonByCMD(List<File> foundVersions, Key root) throws IOException,
            UnsupportedEncodingException {
        ProcessBuilder process = new ProcessBuilder();
        String path = root.getPath() + "\\SOFTWARE\\Python\\PythonCore";
        process.command("REG", "QUERY", path, "/s", "/reg:64");
        process.redirectErrorStream(true);
        Process p = process.start();
        p.getOutputStream().flush();
        p.getOutputStream().close();
        InputStream is = p.getInputStream();
        StringBuffer sb = new StringBuffer();
        byte[] caches = new byte[1024];
        try{
            int len = -1;
            while ((len = is.read(caches)) != -1) {
                sb.append(new String(caches, 0, len, "gbk"));
            }
        }finally{
            if(is!=null){
                is.close();
            }
        }
        Pattern pt = Pattern.compile(path.replace("\\", "\\\\") + "\\\\([0-9\\.]+)\\\\" + "InstallPath");
        String[] lines = sb.toString().split("\r\n");
        boolean find = false;
        for (String line : lines) {
            if (find) {
                String valueType = "REG_SZ";
                String loc = line.substring(line.indexOf(valueType) + valueType.length()).trim();
                File file = new File(loc, "python.exe");
                if (file.isFile()&&file.exists()) {
                    foundVersions.add(file);
                }
                find = false;
            }
            Matcher m = pt.matcher(line);
            if (m.matches()) {
//                System.out.println(m.group(1));
                find = true;
            }
        }
    }

    protected void doFillIntoGrid(Composite parent, int numColumns) {
        super.doFillIntoGrid(parent, numColumns);
        this.autoConfigButton.setToolTipText("Will try to find Python on the PATH (will fail if not available)");
    }

}
