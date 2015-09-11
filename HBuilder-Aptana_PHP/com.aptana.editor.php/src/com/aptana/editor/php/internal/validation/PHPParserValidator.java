package com.aptana.editor.php.internal.validation;

import org.eclipse.core.resources.IProject;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.swt.widgets.Display;
import org.eclipse.ui.IEditorPart;
import org.eclipse.ui.PlatformUI;

import com.aptana.core.build.AbstractBuildParticipant;
import com.aptana.core.logging.IdeLog;
import com.aptana.editor.common.CommonEditorPlugin;
import com.aptana.editor.php.PHPEditorPlugin;
import com.aptana.editor.php.internal.ui.editor.PHPSourceEditor;
import com.aptana.index.core.build.BuildContext;

/**
 * Description: php内置语法校验器(只是个空壳, 真正的校验是在语法树的建立时做的, 报告器是 BuildProblemReporter)
 * Copyright (c) Department of Research and Development/Beijing/Digital Heaven.
 * All Rights Reserved.
 * @version 1.0  2014-9-17 下午2:44:52  by 黄磊（huanglei@d-heaven.com）创建
 */
public class PHPParserValidator extends AbstractBuildParticipant
{
	public static final String ID = "com.aptana.editor.php.internal.validation.PHPParserValidator";
	private int kind;
	@Override
	public void buildStarting(IProject project, int kind, IProgressMonitor monitor)
	{
		super.buildStarting(project, kind, monitor);
		this.kind = kind;
	}
	
	public void buildFile(BuildContext context, IProgressMonitor monitor)
	{
		if(kind == CommonEditorPlugin.VALIDATOR_BUILD_TYPE){
			try{
				final PHPSourceEditor[] editor = new PHPSourceEditor[1];
				Display.getDefault().syncExec(new Runnable(){
					public void run()
					{
						IEditorPart edit = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getActivePage().getActiveEditor();
						if(edit instanceof PHPSourceEditor){
							editor[0] = ((PHPSourceEditor)edit);
						}
					}
				});
				if(editor[0] != null){
					editor[0].getAST(BuildType.BUILD.toString());
				}
			}
			catch (Exception e)
			{
				IdeLog.logError(PHPEditorPlugin.getDefault(), e);
			}
		}
	}

	public void deleteFile(BuildContext context, IProgressMonitor monitor)
	{
	}

	public void initContext(BuildContext context)
	{
		
	}
}
