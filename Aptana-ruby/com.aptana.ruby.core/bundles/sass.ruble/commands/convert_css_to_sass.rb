require 'ruble'

command t(:convert_css_to_sass) do |cmd|
  #cmd.key_binding = 'OPTION+COMMAND+C'
  cmd.output = :replace_selection
  cmd.input = :selection
  cmd.invoke do |context|
    cmd_line = "ruby -e \"require 'rubygems'; gem 'haml'; require 'sass/css'; puts Sass::CSS.new(STDIN.read).render\""
    IO.popen(cmd_line, 'r+') do |io|
      io << ENV['TM_SELECTED_TEXT']
      io.close_write
      io.read
    end
  end
end