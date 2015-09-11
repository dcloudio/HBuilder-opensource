package com.aptana.editor.php.internal.ui.editor.outline;

import org.eclipse.jface.viewers.LabelProvider;
import org.eclipse.swt.graphics.Image;
import org2.eclipse.php.core.compiler.PHPFlags;

import com.aptana.core.util.StringUtil;
import com.aptana.editor.php.PHPEditorPlugin;
import com.aptana.editor.php.indexer.IPHPIndexConstants;
import com.aptana.editor.php.internal.indexer.AbstractPHPEntryValue;
import com.aptana.editor.php.internal.parser.nodes.IPHPParseNode;
import com.aptana.editor.php.internal.parser.nodes.PHPBaseParseNode;
import com.aptana.editor.php.internal.parser.nodes.PHPClassParseNode;
import com.aptana.editor.php.internal.parser.nodes.PHPConstantNode;
import com.aptana.editor.php.internal.parser.nodes.PHPFunctionParseNode;
import com.aptana.editor.php.internal.parser.nodes.PHPIncludeNode;
import com.aptana.editor.php.internal.parser.nodes.PHPNamespaceNode;
import com.aptana.editor.php.internal.parser.nodes.PHPVariableParseNode;
import com.aptana.parsing.ast.INameNode;
import com.aptana.parsing.ast.IParseNode;

public class PHPOutlineLabelProvider extends LabelProvider
{
	/**
	 * PROPERTY_ICON
	 */
	public static final Image PROPERTY_ICON = PHPEditorPlugin.getImage("icons/full/obj16/php_property.png"); //$NON-NLS-1$
	public static final Image PROPERTY_OULINE_ICON = PHPEditorPlugin.getImage("icons/full/outline/php_property.png"); //$NON-NLS-1$

	/**
	 * FUNCTION_ICON
	 */
	public static final Image FUNCTION_ICON = PHPEditorPlugin.getImage("icons/full/obj16/php_function.png"); //$NON-NLS-1$
	public static final Image FUNCTION_OULINE_ICON = PHPEditorPlugin.getImage("icons/full/outline/php_function.png"); //$NON-NLS-1$

	/**
	 * CLASS_ICON
	 */
	public static final Image CLASS_ICON = PHPEditorPlugin.getImage("icons/full/obj16/php_class.png"); //$NON-NLS-1$
	public static final Image CLASS_OULINE_ICON = PHPEditorPlugin.getImage("icons/full/outline/php_class.png"); //$NON-NLS-1$

	/**
	 * TRAIT_ICON
	 */
	public static final Image TRAIT_ICON = PHPEditorPlugin.getImage("icons/full/obj16/php_trait.png"); //$NON-NLS-1$
	public static final Image TRAIT_OULINE_ICON = PHPEditorPlugin.getImage("icons/full/outline/php_trait.png"); //$NON-NLS-1$

	/**
	 * INTERFACE_ICON
	 */
	public static final Image INTERFACE_ICON = PHPEditorPlugin.getImage("icons/full/obj16/php_interface.png"); //$NON-NLS-1$
	public static final Image INTERFACE_OULINE_ICON = PHPEditorPlugin.getImage("icons/full/outline/php_interface.png"); //$NON-NLS-1$

	/**
	 * PRIVATE_METHOD_ICON
	 */
	public static final Image PRIVATE_METHOD_ICON = PHPEditorPlugin.getImage("icons/full/obj16/methpri_obj.png"); //$NON-NLS-1$
	public static final Image PRIVATE_METHOD_OULINE_ICON = PHPEditorPlugin.getImage("icons/full/outline/methpri_obj.png"); //$NON-NLS-1$

	/**
	 * PROTECTED_METHOD_ICON
	 */
	public static final Image PROTECTED_METHOD_ICON = PHPEditorPlugin.getImage("icons/full/obj16/methpro_obj.png"); //$NON-NLS-1$
	public static final Image PROTECTED_METHOD_OULINE_ICON = PHPEditorPlugin.getImage("icons/full/outline/methpro_obj.png"); //$NON-NLS-1$

	/**
	 * PUBLIC_METHOD_ICON
	 */
	public static final Image PUBLIC_METHOD_ICON = PHPEditorPlugin.getImage("icons/full/obj16/methpub_obj.png"); //$NON-NLS-1$
	public static final Image PUBLIC_METHOD_OULINE_ICON = PHPEditorPlugin.getImage("icons/full/outline/methpub_obj.png"); //$NON-NLS-1$

	/**
	 * PRIVATE_FIELD_ICON
	 */
	public static final Image PRIVATE_FIELD_ICON = PHPEditorPlugin.getImage("icons/full/obj16/field_private_obj.png"); //$NON-NLS-1$
	public static final Image PRIVATE_FIELD_OULINE_ICON = PHPEditorPlugin.getImage("icons/full/outline/field_private_obj.png"); //$NON-NLS-1$

	/**
	 * PROTECTED_FIELD_ICON
	 */
	public static final Image PROTECTED_FIELD_ICON = PHPEditorPlugin.getImage("icons/full/obj16/field_protected_obj.png"); //$NON-NLS-1$
	public static final Image PROTECTED_FIELD_OULINE_ICON = PHPEditorPlugin.getImage("icons/full/outline/field_protected_obj.png"); //$NON-NLS-1$

	/**
	 * DEFAULT_FIELD_ICON
	 */
	public static final Image DEFAULT_FIELD_ICON = PHPEditorPlugin.getImage("icons/full/obj16/field_default_obj.png"); //$NON-NLS-1$
	public static final Image DEFAULT_FIELD_OULINE_ICON = PHPEditorPlugin.getImage("icons/full/outline/field_default_obj.png"); //$NON-NLS-1$

	/**
	 * PUBLIC_FIELD_ICON
	 */
	public static final Image PUBLIC_FIELD_ICON = PHPEditorPlugin.getImage("icons/full/obj16/field_public_obj.png"); //$NON-NLS-1$
	public static final Image PUBLIC_FIELD_OULINE_ICON = PHPEditorPlugin.getImage("icons/full/outline/field_public_obj.png"); //$NON-NLS-1$

	/**
	 * LOCALVARIABLE_ICON
	 */
	public static final Image LOCALVARIABLE_ICON = PHPEditorPlugin.getImage("icons/full/obj16/localvariable_obj.png"); //$NON-NLS-1$
	public static final Image LOCALVARIABLE_OULINE_ICON = PHPEditorPlugin.getImage("icons/full/outline/localvariable_obj.png"); //$NON-NLS-1$

	/**
	 * LOCALVARIABLE_ICON
	 */
	public static final Image NAMESPACE_ICON = PHPEditorPlugin.getImage("icons/full/obj16/namespace_obj.png"); //$NON-NLS-1$
	public static final Image NAMESPACE_OULINE_ICON = PHPEditorPlugin.getImage("icons/full/outline/namespace_obj.png"); //$NON-NLS-1$

	/**
	 * IMPORT_ICON
	 */
	public static final Image IMPORT_ICON = PHPEditorPlugin.getImage("icons/full/obj16/imp_obj.png"); //$NON-NLS-1$
	public static final Image IMPORT_OULINE_ICON = PHPEditorPlugin.getImage("icons/full/outline/imp_obj.png"); //$NON-NLS-1$

	public static final Image BLOCK_ICON = PHPEditorPlugin.getImage("icons/full/obj16/php_key.png"); //$NON-NLS-1$
	public static final Image BLOCK_OULINE_ICON = PHPEditorPlugin.getImage("icons/full/outline/php_key.png"); //$NON-NLS-1$

	private static final String EMPTY_STRING = ""; //$NON-NLS-1$

	// Template PHPBaseParseNodes that we use to convert AbstractPHPEntryValue to PHPBaseParseNodes (see getParseNode).
	// The AbstractPHPEntryValue are usually arriving from the content assist system.
	private static final PHPBaseParseNode classParseNodeTemplate = new PHPClassParseNode(0, 0, 0, EMPTY_STRING);
	private static final PHPBaseParseNode constantParseNodeTemplate = new PHPConstantNode(0, 0, EMPTY_STRING);
	private static final PHPBaseParseNode functionParseNodeTemplate = new PHPFunctionParseNode(0, 0, 0, EMPTY_STRING);
	private static final PHPBaseParseNode namespaceParseNodeTemplate = new PHPNamespaceNode(0, 0, EMPTY_STRING,
			EMPTY_STRING);
	private static final PHPBaseParseNode includeParseNodeTemplate = new PHPIncludeNode(0, 0, EMPTY_STRING,
			EMPTY_STRING);
	private static final PHPBaseParseNode variableParseNodeTemplate = new PHPVariableParseNode(0, 0, 0, EMPTY_STRING,
			true);
	
	private boolean isOutline;

	public PHPOutlineLabelProvider(boolean isOutline) {
		this.isOutline = isOutline;
	}
	/*
	 * (non-Javadoc)
	 * @see org.eclipse.jface.viewers.LabelProvider#getText(java.lang.Object)
	 */
	@Override
	public String getText(Object element)
	{
		PHPBaseParseNode parseNode = getParseNode(element);
		if (parseNode != null)
		{
			INameNode nameNode = parseNode.getNameNode();
			String name = nameNode.getName();
			if (StringUtil.isEmpty(name))
			{
				return parseNode.getNodeName();
			}
			return name;
		}
		return super.getText(element);
	}

	/*
	 * (non-Javadoc)
	 * @see org.eclipse.jface.viewers.LabelProvider#getImage(java.lang.Object)
	 */
	@Override
	public Image getImage(Object element)
	{
		Image result;
		PHPBaseParseNode parseNode = getParseNode(element);
		if (parseNode != null)
		{
			int modifiers = parseNode.getModifiers();
			switch (parseNode.getNodeType())
			{
				case IPHPParseNode.BLOCK_NODE:
				case IPHPParseNode.KEYWORD_NODE:
					return isOutline?BLOCK_OULINE_ICON:BLOCK_ICON;
				case IPHPParseNode.IMPORT_NODE:
				case IPHPParseNode.USE_NODE:
					return isOutline?IMPORT_OULINE_ICON:IMPORT_ICON;
				case IPHPParseNode.VAR_NODE:
				{
					result = getVariableNodeImage(parseNode, modifiers);
					break;
				}
				case IPHPParseNode.FUNCTION_NODE:
				{
					result = getFunctionNodeImage(parseNode, modifiers);
					break;
				}

				case IPHPParseNode.NAMESPACE_NODE:
					result = isOutline?NAMESPACE_OULINE_ICON:NAMESPACE_ICON;
					break;
				case IPHPParseNode.CLASS_NODE:
					result = getClassNodeImage(modifiers);
					break;
				case IPHPParseNode.TRAIT_NODE:
					result = isOutline?TRAIT_OULINE_ICON:TRAIT_ICON;
					break;
				default:
					result = getDefaultImage(element);
					break;
			}
		}
		else
		{
			result = getDefaultImage(element);
		}

		return result;
	}

	private Image getDefaultImage(Object element)
	{
		return isOutline?BLOCK_OULINE_ICON:BLOCK_ICON;
	}

	private PHPBaseParseNode getParseNode(Object element)
	{
		if (element instanceof PHPOutlineItem)
		{
			IParseNode referenceNode = ((PHPOutlineItem) element).getReferenceNode();
			return (PHPBaseParseNode) referenceNode;
		}
		else if (element instanceof AbstractPHPEntryValue)
		{
			// Convert this content-assist AbstractPHPEntryValue item to a PHPBaseParseNode
			AbstractPHPEntryValue value = (AbstractPHPEntryValue) element;
			PHPBaseParseNode result = null;
			switch (value.getKind())
			{
				case IPHPIndexConstants.CLASS_CATEGORY:
					result = classParseNodeTemplate;
					break;
				case IPHPIndexConstants.CONST_CATEGORY:
					result = constantParseNodeTemplate;
					break;
				case IPHPIndexConstants.FUNCTION_CATEGORY:
					result = functionParseNodeTemplate;
					break;
				case IPHPIndexConstants.IMPORT_CATEGORY:
					result = includeParseNodeTemplate;
					break;
				case IPHPIndexConstants.NAMESPACE_CATEGORY:
					result = namespaceParseNodeTemplate;
					break;
				case IPHPIndexConstants.VAR_CATEGORY:
					result = variableParseNodeTemplate;
					break;
			}
			if (result != null)
			{
				result.setModifiers(value.getModifiers());
				return result;
			}
		}
		return null;
	}

	private Image getVariableNodeImage(PHPBaseParseNode parseNode, int modifiers)
	{
		Image result;
		result = isOutline?PROPERTY_OULINE_ICON:PROPERTY_ICON;
		PHPVariableParseNode fn = (PHPVariableParseNode) parseNode;
		if (fn.isParameter() || fn.isLocalVariable())
		{
			return isOutline?LOCALVARIABLE_OULINE_ICON:LOCALVARIABLE_ICON;
		}
		if (fn.isField())
		{
			if (PHPFlags.isPublic(modifiers))
			{
				result = isOutline?PUBLIC_FIELD_OULINE_ICON:PUBLIC_FIELD_ICON;
			}
			else if (PHPFlags.isProtected(modifiers))
			{
				result = isOutline?PROTECTED_FIELD_OULINE_ICON:PROTECTED_FIELD_ICON;
			}
			else if (PHPFlags.isPrivate(modifiers))
			{
				result = isOutline?PRIVATE_FIELD_OULINE_ICON:PRIVATE_FIELD_ICON;
			}
			else
			{
				result = isOutline?DEFAULT_FIELD_OULINE_ICON:DEFAULT_FIELD_ICON;
			}
		}
		return result;
	}

	private Image getClassNodeImage(int modifiers)
	{
		Image result;
		if (PHPFlags.isInterface(modifiers))
		{
			result = isOutline?INTERFACE_OULINE_ICON:INTERFACE_ICON;
		}
		else
		{
			result = isOutline?CLASS_OULINE_ICON:CLASS_ICON;
		}
		return result;
	}

	private Image getFunctionNodeImage(PHPBaseParseNode parseNode, int modifiers)
	{
		Image result;
		PHPFunctionParseNode fn = (PHPFunctionParseNode) parseNode;
		result = isOutline?FUNCTION_OULINE_ICON:FUNCTION_ICON;
		if (fn.isMethod())
		{
			if (PHPFlags.isPublic(modifiers))
			{
				result = isOutline?FUNCTION_OULINE_ICON:FUNCTION_ICON;
			}
			else if (PHPFlags.isProtected(modifiers))
			{
				result = isOutline?PROTECTED_METHOD_OULINE_ICON:PROTECTED_METHOD_ICON;
			}
			else if (PHPFlags.isPrivate(modifiers))
			{
				result = isOutline?PRIVATE_METHOD_OULINE_ICON:PRIVATE_METHOD_ICON;
			}
			else
			{
				result = isOutline?PUBLIC_METHOD_OULINE_ICON:PUBLIC_METHOD_ICON;
			}
		}
		return result;
	}
}
