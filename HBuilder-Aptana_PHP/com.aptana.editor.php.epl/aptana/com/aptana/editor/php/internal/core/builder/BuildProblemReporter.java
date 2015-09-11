/*******************************************************************************
 * Copyright (c) 2008 xored software, Inc.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     xored software, Inc. - initial API and Implementation (Alex Panchenko)
 *******************************************************************************/
package com.aptana.editor.php.internal.core.builder;

import java.lang.reflect.Field;
import java.net.URI;
import java.text.MessageFormat;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IMarker;
import org.eclipse.core.resources.IResource;
import org.eclipse.core.resources.IWorkspace;
import org.eclipse.core.resources.IWorkspaceRunnable;
import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.NullProgressMonitor;
import org.eclipse.core.runtime.jobs.ISchedulingRule;
import org.eclipse.core.runtime.preferences.IEclipsePreferences;
import org.eclipse.swt.widgets.Display;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.IEditorPart;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.part.FileEditorInput;
import org2.eclipse.dltk.compiler.problem.CategorizedProblem;
import org2.eclipse.dltk.compiler.problem.DefaultProblem;
import org2.eclipse.dltk.compiler.problem.IProblem;
import org2.eclipse.dltk.compiler.problem.ProblemCollector;
import org2.eclipse.php.internal.core.preferences.CorePreferenceConstants;

import com.aptana.core.build.IBuildParticipant.BuildType;
import com.aptana.core.build.PreferenceUtil;
import com.aptana.core.logging.IdeLog;
import com.aptana.core.resources.IUniformResource;
import com.aptana.core.resources.MarkerUtils;
import com.aptana.core.util.CollectionsUtil;
import com.aptana.core.util.EclipseUtil;
import com.aptana.core.util.StringUtil;
import com.aptana.editor.php.epl.PHPEplPlugin;

/**
 * A problem reporter that can work on a workspace resource or on an external resource, {@link IUniformResource}.
 */
public class BuildProblemReporter extends ProblemCollector
{

	public static final Pattern filterSplitter = Pattern.compile("####");
	public static final String PHPParserValidator_ID = "com.aptana.editor.php.internal.validation.PHPParserValidator";
	/*
	 * This can hold an IResource or an IUniformResource, in case the resource is out of workspace.
	 */
	private final Object resource;
	private boolean oldMarkersDeleted = false;
	private boolean isExternal;
	private String resourceLocation;
	private BuildType type;
	/**
	 * We lazily compile the filters into {@link Pattern}s as we try to match them.
	 */
	private Map<String, Pattern> compiledFilters;

	/**
	 * Constructs a new BuildProblemReporter for a given resource.
	 * 
	 * @param resource
	 *            Can be {@link IResource} or an {@link IUniformResource}
	 */
	public BuildProblemReporter(Object resource, BuildType type)
	{
		this.type = type;
		this.isExternal = (resource instanceof IUniformResource);
		if (isExternal || resource instanceof IResource)
		{
			this.resource = resource;
		}
		else
		{
			throw new IllegalArgumentException(
					"The given resource is expected to be an IResource or an IUniformResource"); //$NON-NLS-1$
		}
		resourceLocation = StringUtil.EMPTY;
	}

	private static ISchedulingRule getMarkerRule(Object resource)
	{
		if (resource instanceof IResource)
		{
			return ResourcesPlugin.getWorkspace().getRuleFactory().markerRule((IResource) resource);
		}
		return null;
	}

	public void flush()
	{
		// Performance fix: schedules the error handling as a single workspace update so that we don't trigger a
		// bunch of resource updated events while problem markers are being added to the file.
		IWorkspaceRunnable runnable = new IWorkspaceRunnable()
		{
			public void run(IProgressMonitor monitor)
			{
				updateMarkers();
			}
		};
		try
		{
			ResourcesPlugin.getWorkspace().run(runnable, getMarkerRule(resource), IWorkspace.AVOID_UPDATE,
					new NullProgressMonitor());
		}
		catch (CoreException e)
		{
			IdeLog.logWarning(PHPEplPlugin.getDefault(),
					MessageFormat.format(Messages.BuildProblemReporter_UpdateMarkersError, resourceLocation), e,
					PHPEplPlugin.DEBUG_SCOPE);
		}

	}

	private void updateMarkers()
	{
		try
		{
			if (EclipseUtil.isTesting())
			{
				return;
			}
			IResource workspaceResource = null;
			IUniformResource externalResource = null;
			if (isExternal)
			{
				externalResource = (IUniformResource) resource;
				URI uri = externalResource.getURI();
				if (uri != null)
				{
					resourceLocation = uri.getPath();
				}
			}
			else
			{
				workspaceResource = (IResource) resource;
				if (workspaceResource == null || !workspaceResource.isAccessible())
				{
					IdeLog.logWarning(PHPEplPlugin.getDefault(),
							"BuildProblemReporter::flush -> Unexpected null or non-accessible resource"); //$NON-NLS-1$
					return;
				}
				resourceLocation = workspaceResource.getLocation().toString();
			}
			if (!oldMarkersDeleted)
			{
				oldMarkersDeleted = true;
				if (isExternal)
				{
					if(BuildType.BUILD == type) {//BuildType.BUILD的情况下需要删除错误信息
						MarkerUtils.deleteMarkers(externalResource, DefaultProblem.MARKER_TYPE_PROBLEM, true);
					}
					MarkerUtils.deleteMarkers(externalResource, DefaultProblem.MARKER_TYPE_TASK, true);
				}else{
					if(BuildType.BUILD == type) {//BuildType.BUILD的情况下需要删除错误信息
						workspaceResource.deleteMarkers(DefaultProblem.MARKER_TYPE_PROBLEM, true, IResource.DEPTH_INFINITE);
					}
					workspaceResource.deleteMarkers(DefaultProblem.MARKER_TYPE_TASK, true, IResource.DEPTH_INFINITE);
				}
			}
			List<String> expressions = getFilters();
			for (final IProblem problem : problems)
			{
				final String markerType;
				if (problem instanceof CategorizedProblem)
				{
					markerType = ((CategorizedProblem) problem).getMarkerType();
				}
				else
				{
					markerType = DefaultProblem.MARKER_TYPE_PROBLEM;
				}
				//buildtype类型不匹配或信息被忽略的情况下不需要报告错误信息
				if(DefaultProblem.MARKER_TYPE_PROBLEM.equals(markerType)
						&& (!isEnableForBuildType() 
								|| isIgnored(problem.getMessage(), expressions))) {
						 continue;
				}
				IMarker m = null;
				if (isExternal)
				{
					m = MarkerUtils.createMarker(externalResource, null, markerType);
					// Make sure we don't persist this marker on an external file.
					m.setAttribute(IMarker.TRANSIENT, true);
				}
				else
				{
					m = workspaceResource.createMarker(markerType);
				}
				if (m == null || !m.exists())
				{
					IdeLog.logError(PHPEplPlugin.getDefault(), "Error creating a PHP marker", PHPEplPlugin.DEBUG_SCOPE); //$NON-NLS-1$
				}
				if (problem.getSourceLineNumber() >= 0)
				{
					m.setAttribute(IMarker.LINE_NUMBER, problem.getSourceLineNumber() + 1);
				}
				m.setAttribute(IMarker.MESSAGE, problem.getMessage());
				if (problem.getSourceStart() >= 0)
				{
					m.setAttribute(IMarker.CHAR_START, problem.getSourceStart());
				}
				if (problem.getSourceEnd() >= 0)
				{
					m.setAttribute(IMarker.CHAR_END, problem.getSourceEnd());
				}
				if (DefaultProblem.MARKER_TYPE_PROBLEM.equals(markerType))
				{
					int severity = IMarker.SEVERITY_INFO;
					if (problem.isError())
					{
						severity = IMarker.SEVERITY_ERROR;
					}
					else if (problem.isWarning())
					{
						severity = IMarker.SEVERITY_WARNING;
					}
					m.setAttribute(IMarker.SEVERITY, severity);
				}
				else
				{
					m.setAttribute(IMarker.USER_EDITABLE, Boolean.FALSE);
					if (problem instanceof TaskInfo)
					{
						m.setAttribute(IMarker.PRIORITY, ((TaskInfo) problem).getPriority());
					}
				}
			}
		}
		catch (CoreException e)
		{
			IdeLog.logWarning(PHPEplPlugin.getDefault(),
					MessageFormat.format(Messages.BuildProblemReporter_UpdateMarkersError, resourceLocation), e,
					PHPEplPlugin.DEBUG_SCOPE);
		}
		finally
		{
			// in any case, clear the problems
			problems.clear();
		}
	}
	
	/**
	 * Description: 当前的buildtype下是否需要报告错误信息
	 * @Version1.0 2014-9-17 下午3:06:11 by 黄磊（huanglei@d-heaven.com）创建
	 * @return
	 */
	public boolean isEnableForBuildType() {
		try{
			if(BuildType.RECONCILE == type) {
				return false;
			}
			IEclipsePreferences node = EclipseUtil.instanceScope().getNode("com.aptana.editor.php");
			boolean result = node.getBoolean(PreferenceUtil.getEnablementPreferenceKey(PHPParserValidator_ID, type), false);
			if(!result) {
				final IEditorPart[] editor = new IEditorPart[1];
				Display.getDefault().syncExec(new Runnable()
				{
					public void run()
					{
						try{
							editor[0] = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getActivePage().getActiveEditor();
						}catch (Exception e){
						}
					}
				});
				if(editor[0]!=null) {
					IEditorInput input = editor[0].getEditorInput();
					if(input instanceof FileEditorInput) {
						IFile ifile= ((FileEditorInput)input).getFile();
						if(ifile.equals(resource)) {
							Class editorClass = editor[0].getClass();
							Field field = editorClass.getField("openManualValidator");
							field.setAccessible(true);
							return field.getBoolean(editor[0]);
						}
					}
				}
			}
			return result;
		}catch (Exception e){
			IdeLog.logError(PHPEplPlugin.getDefault(), e);
			return false;
		}
	}
	
	/**
	 * Description: 信息是否需要被忽略
	 * @Version1.0 2014-9-17 下午3:05:13 by 黄磊（huanglei@d-heaven.com）创建
	 * @param message
	 * @param expressions
	 * @return
	 */
	protected synchronized boolean isIgnored(String message, List<String> expressions)
	{
		if (CollectionsUtil.isEmpty(expressions) || message==null)
		{
			return false;
		}

		if (compiledFilters == null)
		{
			compiledFilters = new HashMap<String, Pattern>(expressions.size());
		}
		try{
			for (String expression : expressions)
			{
				// Lazily compile the filter expressions into Patterns
				Pattern p = compiledFilters.get(expression);
				if (p == null)
				{
					p = Pattern.compile(expression);
					compiledFilters.put(expression, p);
				}
				if (p.matcher(message).matches())
				{
					return true;
				}
			}
		}
		catch (Exception e){
			IdeLog.logError(PHPEplPlugin.getDefault(), e);
		}

		return false;
	}
	
	/**
	 * Description: 获取要忽略错误信息过滤表达式
	 * @Version1.0 2014-9-17 下午3:04:30 by 黄磊（huanglei@d-heaven.com）创建
	 * @return
	 */
	private List<String> getFilters()
	{
		String rawFilters = CorePreferenceConstants.getPreferenceStore().getString(getFiltersPreferenceKey());
		if (StringUtil.isEmpty(rawFilters))
		{
			return Collections.emptyList();
		}
		return Arrays.asList(filterSplitter.split(rawFilters));
	}

	private String getFiltersPreferenceKey()
	{
		return PreferenceUtil.getFiltersKey(PHPParserValidator_ID);
	}
	
}
