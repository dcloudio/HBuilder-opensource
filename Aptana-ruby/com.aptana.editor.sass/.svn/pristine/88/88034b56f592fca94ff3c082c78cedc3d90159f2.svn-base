/**
 * Aptana Studio
 * Copyright (c) 2005-2011 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the GNU Public License (GPL) v3 (with exceptions).
 * Please see the license.html included with this distribution for details.
 * Any modifications to this file must keep this entire header intact.
 */
package com.aptana.editor.sass;

import org.eclipse.jface.preference.IPreferenceStore;
import org.eclipse.jface.text.IAutoEditStrategy;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.source.ISourceViewer;

import com.aptana.editor.common.AbstractThemeableEditor;
import com.aptana.editor.common.ISourceViewerConfiguration;
import com.aptana.editor.common.TextUtils;
import com.aptana.editor.css.CSSSourceConfiguration;
import com.aptana.editor.css.CSSSourceViewerConfiguration;

public class SassSourceViewerConfiguration extends CSSSourceViewerConfiguration
{
	/**
	 * SassSourceViewerConfiguration
	 * 
	 * @param preferences
	 * @param editor
	 */
	public SassSourceViewerConfiguration(IPreferenceStore preferences, AbstractThemeableEditor editor)
	{
		super(preferences, editor);
	}

	/*
	 * (non-Javadoc)
	 * @see com.aptana.editor.common.SimpleSourceViewerConfiguration#getSourceViewerConfiguration()
	 */
	@Override
	public ISourceViewerConfiguration getSourceViewerConfiguration()
	{
		return SassSourceConfiguration.getDefault();
	}

	@Override
	public IAutoEditStrategy[] getAutoEditStrategies(ISourceViewer sourceViewer, String contentType)
	{
		return super.getAutoEditStrategies(sourceViewer, contentType);
	}
	
	public String[] getConfiguredContentTypes(ISourceViewer sourceViewer) {
		String[] superTypes =  TextUtils.combine(new String[][] { { IDocument.DEFAULT_CONTENT_TYPE }, SassSourceConfiguration.CONTENT_TYPES });
		return TextUtils.combine(new String[][] { superTypes, CSSSourceConfiguration.CONTENT_TYPES });
	}
}
