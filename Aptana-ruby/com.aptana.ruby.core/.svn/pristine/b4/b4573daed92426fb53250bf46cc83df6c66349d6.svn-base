require 'ruble'

command t(:omit) do |cmd|
  #cmd.key_binding = 'Command+Shift+Control+O'
  cmd.scope = 'source.ruby'
  cmd.output = :insert_as_snippet
  cmd.input = :selection, :line
  cmd.invoke do |context|
    s = STDIN.read
    str = "\#--\n"
    if s == ""
      str << "\# $0\n\#++\n"
    else
      str << "#{s}\n\#++\n$0\n"
    end
    str
  end
end
