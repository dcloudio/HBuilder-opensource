require 'ruble'
require 'ruble/ui'

command t(:new_method) do |cmd|
  #cmd.key_binding = 'Shift+Return'
  cmd.scope = 'source.ruby'
  cmd.output = :insert_as_snippet
  cmd.input = :selection, :word
  cmd.invoke do |context|
    require "escape"
    
    method_name = STDIN.read
    if method_name.nil? || method_name.strip == ""
      Ruble::UI.tool_tip("Please type the new function's name or use the def? snippet.")
      nil
    else
"def #{e_sn method_name}(${1:args})
  \$0
end"
    end
  end
end
