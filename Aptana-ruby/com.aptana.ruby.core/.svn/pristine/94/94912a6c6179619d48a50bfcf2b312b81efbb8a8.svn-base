require 'ruble'

command t(:toggle_string_symbol) do |cmd|
  #cmd.key_binding = 'CTRL+M2+;' # CTRL+:
  cmd.output = :replace_selection
  cmd.input = :selection, :scope
  cmd.scope = "source.ruby string.quoted, source.ruby constant.other.symbol.ruby"
  cmd.invoke do |context|
    case str = STDIN.read
      # Handle standard quotes
      when /\A["'](\w+)["']\z/ then ":" + $1
      when /\A:(\w+)\z/ then '"' + $1 + '"'
      # Default case
      else nil # do nothing
    end
  end
end
