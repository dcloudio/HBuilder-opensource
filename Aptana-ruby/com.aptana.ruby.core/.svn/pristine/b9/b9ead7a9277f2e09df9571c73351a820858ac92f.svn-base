/**
 * Aptana Studio
 * Copyright (c) 2005-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the GNU Public License (GPL) v3 (with exceptions).
 * Please see the license.html included with this distribution for details.
 * Any modifications to this file must keep this entire header intact.
 */
package com.aptana.ruby.internal.core.build;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;

import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.SubMonitor;
import org.eclipse.jface.text.Document;
import org.eclipse.jface.text.IDocument;

import com.aptana.build.util.BuildHelper;
import com.aptana.core.build.IProblem;
import com.aptana.core.build.RequiredBuildParticipant;
import com.aptana.core.resources.IMarkerConstants;
import com.aptana.core.util.ArrayUtil;
import com.aptana.index.core.build.BuildContext;
import com.aptana.parsing.ast.IParseNode;
import com.aptana.parsing.ast.IParseRootNode;
import com.aptana.ruby.internal.core.RubyComment;

/**
 * Detects task markers in ruby comments.
 * 
 * @author cwilliams
 */
public class RubyTaskDetector extends RequiredBuildParticipant
{

	public void buildFile(BuildContext context, IProgressMonitor monitor)
	{
		if (context == null)
		{
			return;
		}
		if(!context.isFullBuild()&&!context.isSave()){
			return;
		}
		Collection<IProblem> tasks = detectTasks(context, monitor);
		context.putProblems(IMarkerConstants.TASK_MARKER, tasks);
	}

	public void deleteFile(BuildContext context, IProgressMonitor monitor)
	{
		if (context == null)
		{
			return;
		}
		context.removeProblems(IMarkerConstants.TASK_MARKER);
	}

	private Collection<IProblem> detectTasks(BuildContext context, IProgressMonitor monitor)
	{
		IParseRootNode rootNode = null;
		try
		{
			rootNode = context.getAST();
		}
		catch (CoreException e)
		{
			// ignores the parser exception
		}
		if (rootNode == null)
		{
			return Collections.emptyList();
		}
		IParseNode[] comments = rootNode.getCommentNodes();
		if (ArrayUtil.isEmpty(comments))
		{
			return Collections.emptyList();
		}

		Collection<IProblem> tasks = new ArrayList<IProblem>();
		SubMonitor sub = SubMonitor.convert(monitor, comments.length);
		try
		{
			IDocument source = new Document(context.getContents());
			String filePath = context.getURI().toString();
			int i = 0;
			for (IParseNode commentNode : comments)
			{
				if(context.isNeedSleep()){
					i++;
					BuildHelper.sleepLoop(BuildHelper.TASK_TYPE, i);
				}
				if (commentNode instanceof RubyComment)
				{
					tasks.addAll(processCommentNode(filePath, source, 0, commentNode, "=end", context.isNeedSleep())); //$NON-NLS-1$
				}
				sub.worked(1);
			}
		}
		finally
		{
			sub.done();
		}
		return tasks;
	}
}
