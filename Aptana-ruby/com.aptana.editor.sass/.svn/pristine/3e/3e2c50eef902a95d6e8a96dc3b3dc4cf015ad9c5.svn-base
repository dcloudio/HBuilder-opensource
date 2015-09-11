package com.aptana.editor.sass.contentassist;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import org.eclipse.jface.text.BadLocationException;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.ITextViewer;
import org.eclipse.jface.text.ITypedRegion;
import org.eclipse.jface.text.contentassist.ICompletionProposal;

import com.aptana.core.util.StringUtil;
import com.aptana.editor.common.AbstractThemeableEditor;
import com.aptana.editor.css.CSSSourceConfiguration;
import com.aptana.editor.css.contentassist.CSSContentAssistProcessor;
import com.aptana.editor.sass.SassPlugin;
import com.aptana.editor.sass.SassSourceConfiguration;
import com.aptana.parsing.lexer.IRange;
import com.aptana.parsing.lexer.Range;

@SuppressWarnings("restriction")
public class SassContentassistProcessor extends CSSContentAssistProcessor
{
	private static final String[] SASS_CHARS = {"-","@"};
	private static final String[] LESS_CHARS = {"-","@"};
	private boolean isSass = false;
	private static final Set<String> SASS_KEYWORDS_SET = new HashSet<String>();
	
	static{
		SASS_KEYWORDS_SET.add("@extend");
		SASS_KEYWORDS_SET.add("@import");
		SASS_KEYWORDS_SET.add("@mixin");
		SASS_KEYWORDS_SET.add("@include");
		SASS_KEYWORDS_SET.add("@charset");
		SASS_KEYWORDS_SET.add("@media");
		SASS_KEYWORDS_SET.add("@page");
		SASS_KEYWORDS_SET.add("@font-face");
		SASS_KEYWORDS_SET.add("@namespace");
		SASS_KEYWORDS_SET.add("@for");
		SASS_KEYWORDS_SET.add("@function");
		SASS_KEYWORDS_SET.add("@return");
	}

	public SassContentassistProcessor(AbstractThemeableEditor editor)
	{
		super(editor);
	}
	
	@Override
	protected ICompletionProposal[] doComputeCompletionProposals(ITextViewer viewer, int offset, char activationChar,
			boolean autoActivated)
	{
		isSass = false;
		ICompletionProposal[] result = null;
		try
		{
			String fileName = getFilename();
			if(StringUtil.isNotBlank(fileName)){
				fileName = fileName.toLowerCase();
			}else{
				fileName = "";
			}
			if(fileName.endsWith(".sass")||fileName.endsWith(".scss")){
				isSass = true;
			}
			IDocument document = viewer.getDocument();
			if(fileName.endsWith(".sass")){
				return computeWordCompletionProposals(offset, PROPERTY_ICON,SASS_CHARS);
			}else if(fileName.endsWith(".scss")&&needComputeWord(offset, SASS_CHARS, activationChar, document, new String[]{"$","@"})){
				return computeWordCompletionProposals(offset, PROPERTY_ICON,SASS_CHARS);
			}else if(fileName.endsWith(".less")&&needComputeWord(offset, LESS_CHARS, activationChar, document, new String[]{"$","@"})){
				return computeWordCompletionProposals(offset, PROPERTY_ICON,LESS_CHARS);
			}else{
				result = super.doComputeCompletionProposals(viewer, offset, activationChar, autoActivated);
				if(result==null || result.length<1){
					result = computeWordCompletionProposals(offset, PROPERTY_ICON,SASS_CHARS);
				}
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return result;
	}
	
	private boolean needComputeWord(int offset, String[] chars, char activationChar, IDocument document, String[] specChar){
		if(StringUtil.contains(specChar, activationChar+"")){
			return true;
		}
		String prefix = getWordPrefix(offset, chars, document);
		if(StringUtil.isNotBlank(prefix)){
			for (String str : specChar){
				if(prefix.startsWith(str)){
					return true;
				}
			}
		}
		return false;
	}

	@Override
	protected IRange getLexemeRange(IDocument document, int offset)
	{
		int startOffset = 0;
		try
		{
			int testOffset = document.get(0, offset).lastIndexOf('}', offset);
			// add one because we don't want to include the closing brace
			startOffset = (testOffset < 0) ? 0 : testOffset + 1;
		}
		catch (BadLocationException e)
		{
		}
		int endOffset = offset;
		try
		{
			ITypedRegion region = document.getPartition(offset);
			if(region!=null) {
				//如果是注释， 则直接返回整个注释范围
				if(region.getType().equals(CSSSourceConfiguration.MULTILINE_COMMENT) || region.getType().equals(SassSourceConfiguration.MULTI_LINE_COMMENT)) {
					return new Range(region.getOffset(), region.getOffset()+region.getLength());
				}
				String sassPrefix = SassSourceConfiguration.PREFIX;
				String cssPrefix = CSSSourceConfiguration.PREFIX;
				String defaultType = IDocument.DEFAULT_CONTENT_TYPE;
				if(!region.getType().startsWith(cssPrefix) && !region.getType().startsWith(sassPrefix) && !region.getType().equals(defaultType)) {
					//不在css代码内时，尝试 向后退一位取CSS分区
					region = document.getPartition(offset-1);
				}
				if(region.getType().startsWith(cssPrefix) || region.getType().startsWith(sassPrefix) || region.getType().equals(defaultType)) {
					//在html中时判断css区域的范围
					int start = region.getOffset()-1;
					if(start>0) {
						String type = document.getContentType(start);
						if(type==null || ( !type.equals(defaultType) && !type.startsWith(cssPrefix) && !type.startsWith(sassPrefix) )) {
							startOffset = region.getOffset();
						}
					}
					if(document.get(region.getOffset(), region.getLength()).trim().endsWith(":")) {
						ITypedRegion nextRegion = document.getPartition(region.getOffset() + region.getLength());
						if(nextRegion!=null) {
							region = nextRegion;
						}
					}
					endOffset = Math.max(startOffset, region.getOffset() + region.getLength() - 1);
				}else {
					return null;
				}
			}
		}
		catch (BadLocationException e)
		{
		}

		return new Range(startOffset, endOffset);
	}

	@Override
	protected Set<String> computeSpecialWords()
	{
		if(isSass){
			return SASS_KEYWORDS_SET;
		}
		return Collections.emptySet();
	}
	
	protected String getPreferenceNodeQualifier()
	{
		return SassPlugin.PLUGIN_ID;
	}

}
