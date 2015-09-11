require 'ruble'

command 'Toggle Quote Style' do |cmd|
  #cmd.key_binding = 'Control+M2+\''
  #cmd.scope = 'source.ruby string.quoted.double, source.ruby string.quoted.single, source.ruby string'
  cmd.scope = 'source.ruby'
  cmd.output = :replace_selection
  cmd.input = :selection, :scope
  cmd.invoke do |context|    
    class String
      def escape(char)
        gsub(/\\.|#{Regexp.quote(char)}/) { |match| match == char ? "\\#{char}" : match }
      end
    
      def unescape(char)
        gsub(/\\./) { |match| match == "\\#{char}" ? char : match }
      end
    end
    
    case str = STDIN.read
    # Handle standard quotes
    when /\A"(.*)"\z/m
      "'"   + $1.unescape('"').escape("'") + "'"
    when /\A'(.*)'\z/m
      "%Q{" + $1.unescape("'").escape("}") + "}"
    when /\A%[Qq]?\{(.*)\}\z/m
      '"'   + $1.unescape("}").escape('"') + '"'
    # Handle the more esoteric quote styles
    when /\A%[Qq]?\[(.*)(\])\z/m,
         /\A%[Qq]?\((.*)(\))\z/m,
         /\A%[Qq]?<(.*)(>)\z/m
      '"' + $1.unescape($2).escape('"') + '"'
    when /\A%[Qq]?(.)(.*)\1\z/m
      '"' + $2.unescape($1).escape('"') + '"'
    # Handle shell escapes
    when /\A`(.*)`\z/m
      "%x{" + $1.unescape("`").escape("}") + "}"
    when /\A%x\{(.*)\}\z/m
      "`"   + $1.unescape("}").escape("`") + "`"
    # Default case
    else 
      str
    end
  end
end
