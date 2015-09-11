package com.aptana.editor.php.internal.ui.wizard;

import com.pandora.projects.ui.wizards.NewFileWizard;




/**
 * Description: 创建PHP文件向导
 * Copyright (c) Department of Research and Development/Beijing/Digital Heaven.
 * All Rights Reserved.
 * @version 1.0  2013-9-24 下午7:09:12  by 黄磊（huanglei@d-heaven.com）创建
 */
public class NewPhpWizard extends NewFileWizard {

	@Override
	public String getFileType() {
		return "PHP"; //$NON-NLS-1$
	}

	@Override
	public String getFileExt() {
		return "php"; //$NON-NLS-1$
	}

	@Override
	public String getDefaultTemplate() {
		return "template.php"; //$NON-NLS-1$
	}
}
	