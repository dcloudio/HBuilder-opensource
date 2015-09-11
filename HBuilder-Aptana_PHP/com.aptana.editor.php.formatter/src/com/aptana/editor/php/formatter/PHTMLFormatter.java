/**
 * Aptana Studio
 * Copyright (c) 2005-2011 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the GNU Public License (GPL) v3 (with exceptions).
 * Please see the license.html included with this distribution for details.
 * Any modifications to this file must keep this entire header intact.
 */
package com.aptana.editor.php.formatter;

import java.util.Map;

import org.eclipse.jface.text.formatter.IFormattingContext;
import org.eclipse.text.edits.TextEdit;

import com.aptana.editor.html.formatter.HTMLFormatter;
import com.aptana.formatter.ui.FormatterException;

/**
 * @author Shalom Gibly <sgibly@aptana.com>
 */
public class PHTMLFormatter extends HTMLFormatter
{

	/**
	 * @param lineSeparator
	 * @param preferences
	 * @param mainContentType
	 */
	protected PHTMLFormatter(String lineSeparator, Map<String, String> preferences, String mainContentType)
	{
		super(lineSeparator, preferences, mainContentType);
	}
	
	@Override
	public TextEdit format(String source, int offset, int length, int indentationLevel, boolean isSelection,
			IFormattingContext context, String indentSufix) throws FormatterException
	{
		return super.innerFormat(source, offset, length, indentationLevel, isSelection, context, indentSufix);
	}

}
