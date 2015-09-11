require 'ruble'
require 'ruble/editor'

command t(:validate_syntax) do |cmd|
  #cmd.key_binding = 'Control+Shift+V'
  cmd.output = :show_as_tooltip
  cmd.input = :document
  cmd.scope = "source.ruby"
  cmd.invoke do |context|
    result = IO.popen("ruby -wc 2>&1", "r+") do |io|
      io.write STDIN.read
      io.close_write # let the process know you've given it all the data 
      io.read
    end
    Ruble::Editor.go_to :line => $1 if result =~ /-:(\d+):/
    result
  end
end
