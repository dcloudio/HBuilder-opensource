require 'ruble'

command t(:italic) do |cmd|
  #cmd.key_binding = 'M1+SHIFT+I'
  cmd.scope = 'source.ruby comment'
  cmd.output = :insert_as_snippet
  cmd.input = :selection, :word
  cmd.invoke do |context|
    s = STDIN.read
    case s
    when /^\w+$/
      "_#{s}_$0"
    when ""
      "_$1_$0"
    else
      "<em>#{s}</em>"
    end
  end
end
