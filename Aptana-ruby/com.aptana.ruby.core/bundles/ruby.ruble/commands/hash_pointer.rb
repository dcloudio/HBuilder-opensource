require 'ruble'

command "Hash Pointer - =>" do |cmd|
  #cmd.key_binding.mac = 'Control+L'
  #cmd.key_binding = 'Alt+L'
  cmd.output = :insert_as_text
  cmd.input = :none
  cmd.scope = "source.ruby"
  cmd.invoke do |context|
    " => "
  end
end
