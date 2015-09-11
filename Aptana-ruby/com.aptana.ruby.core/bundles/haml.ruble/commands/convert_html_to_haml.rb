require 'ruble'

command t(:convert_html_to_haml) do |cmd|
  # cmd.key_binding = 'M1+M3+C' # Alt + Cmd not friendly for overseas users
  cmd.output = :replace_selection
  cmd.input = :selection, :document
  cmd.invoke do |context|
    cmd_line = "ruby -e \"require 'rubygems'; gem 'haml'; require 'haml/html'; puts Haml::HTML.new(STDIN.read).render\""
    output = IO.popen(cmd_line, 'r+') do |io|
      io << $stdin.read
      io.close_write
      io.read
    end
    if output.nil? or output.strip.length == 0      
      context.exit_show_tooltip "No output. May need to install haml or hpricot gem. hpricot must be installed through Ruby devkit's msys prompt!" if Ruble.is_windows?
      context.exit_discard
    end
    output
  end
end
