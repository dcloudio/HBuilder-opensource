require 'ruble'

command 'each_char { |chr| .. }' do |cmd|
  cmd.trigger = 'eac'
  cmd.scope = 'source.ruby'
  cmd.output = :insert_as_snippet
  cmd.input = :document
  cmd.invoke do |context|    
    require 'ruby_requires'
    require 'insert'
    
    snippet = 'each_char { |${1:chr}| $0 }'
    result = insert_at_cursor(STDIN.read, snippet) {|code| RubyRequires.add_requires(code, 'jcode') }
  end
end
