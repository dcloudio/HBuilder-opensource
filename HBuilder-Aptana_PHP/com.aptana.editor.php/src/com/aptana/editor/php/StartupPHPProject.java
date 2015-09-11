package com.aptana.editor.php;

import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.IProjectDescription;
import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.NullProgressMonitor;
import org.eclipse.ui.IStartup;

import com.aptana.core.logging.IdeLog;
import com.aptana.editor.php.core.PHPNature;
import com.aptana.projects.WebProjectNature;

/**
 * Description: PHP初始自动启动
 * Copyright (c) Department of Research and Development/Beijing/Digital Heaven.
 * All Rights Reserved.
 * @version 1.0  2013-11-7 下午6:37:27  by 黄磊（huanglei@d-heaven.com）创建
 */
public class StartupPHPProject implements IStartup{

	public void earlyStartup()
	{
		//自动为所有的纯web项目或HMobile项目添加php的支持
		IProject[] ps = ResourcesPlugin.getWorkspace().getRoot().getProjects();
		if (ps != null){
			for (IProject p : ps){
				try{
					if (p.isAccessible()) {
						boolean web = p.hasNature(WebProjectNature.ID);
						boolean hmobile = p.hasNature("com.pandora.projects.ui.MKeyNature");
						if(web 
							&& !hmobile
							&& !p.hasNature(PHPNature.NATURE_ID)){
							IProjectDescription pd = p.getDescription();
							String[] src = pd.getNatureIds();
							String[] dest = new String[src.length + (web?1:2)];
							System.arraycopy(src, 0, dest, 0, src.length);
							if(!web) {
								dest[dest.length - 2] = WebProjectNature.ID;
							}
							dest[dest.length - 1] = PHPNature.NATURE_ID;
							pd.setNatureIds(dest);
							p.setDescription(pd, new NullProgressMonitor());
						}
					}
				}catch (Exception e){
					IdeLog.logError(PHPEditorPlugin.getDefault(), e);
				}
			}
		}

	}

}
