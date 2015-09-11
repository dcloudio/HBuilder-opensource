require 'ruble'
require 'ruble/editor'

command t(:validate_syntax_erb) do |cmd|
  #cmd.key_binding = 'Control+Shift+V'
  cmd.scope = 'text.html.ruby, text.html source.ruby'
  cmd.output = :show_as_tooltip
  cmd.input = :document
  cmd.invoke do |context|
    result = IO.popen("erb -T - -x | ruby -c 2>&1", "r+") do |io|
      io.write STDIN.read
      io.close_write # let the process know you've given it all the data 
      io.read
    end
    Ruble::Editor.go_to :line => $1.to_i if result =~ /-:(\d+):/
    result
  end
end
