require 'ruble'
require 'ruble/ui'

command t(:add_bang_to_method) do |cmd|
  #cmd.key_binding = 'CTRL+M2+1'
  cmd.scope = 'source.ruby'
  cmd.output = :insert_as_snippet
  cmd.input = :selection, :line
  cmd.invoke do |context|
    require "escape"

    cursor = [0xFFFC].pack("U").freeze
    line = STDIN.read
    begin
      line[ENV["TM_LINE_INDEX"].to_i, 0] = cursor
    rescue
      exit
    end
    line.sub!(/\b(chomp|chop|collect|compact|delete|downcase|exit|flatten|gsub|lstrip|map|next|reject|reverse|rstrip|slice|sort|squeeze|strip|sub|succs|swapcase|tr|tr_s|uniq|upcase)\b(?!\!)/, "\\1!")
    line = e_sn(line)
    line.sub!(cursor, "$0")
    if line == ""
      Ruble::UI.tool_tip "Retry this command without a selection."
      nil
    else
      line  
    end
  end
end
