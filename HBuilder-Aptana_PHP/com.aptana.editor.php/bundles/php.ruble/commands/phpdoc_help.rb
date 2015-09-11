require 'ruble'

command t(:help) do |cmd|
  cmd.scope = 'source.php'
  cmd.output = :show_as_html
  cmd.input = :none
  cmd.invoke =<<-EOF
. "$TM_SUPPORT_PATH/lib/webpreview.sh"
html_header PHPDoc

Markdown.pl <<'EOF'

# Snippets

This bundle contains snippets for use with [PHPDoc](http://phpdoc.org/).

 * `doc_c ` - Class
 * `doc_d ` - Define inline constant
 * `doc_f ` - Function
 * `doc_h ` - Document header
 * `doc_i ` - Interface class
 * `doc_s ` - Abstract function signature
 * `doc_v ` - Class variable

There is also a command used for adding documentation to existing entities, move the caret before a class/interface, function, define or variable and use `doc?`.

# Shell Variables

The snippets make use of two environment variables (_set these under Preferences &#x2192; Advanced &#x2192; Shell Variables_).

 * `TM_ORGANIZATION_NAME` - default value of @copyright [+ date]
 * `PHPDOC_AUTHOR` - default value of @author (realname will be used if not set)

If you want docblocks to automatically wrap after 80 columns, you need to set it up:

1. Open the Bundle Editor (&#x2303;&#x2325;&#x2318;B)
2. Find and select the 'Wrap Docblock at 80 Characters' command
3. Click in the white box next to 'Key Equivalent' and press space
4. Close the Bundle Editor
EOF
end
