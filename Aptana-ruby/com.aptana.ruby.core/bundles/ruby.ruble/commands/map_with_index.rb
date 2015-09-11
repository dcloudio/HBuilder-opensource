require 'ruble'

command 'map_with_index { |e, i| .. }' do |cmd|
  cmd.trigger = 'mapwi'
  cmd.scope = 'source.ruby'
  cmd.output = :insert_as_snippet
  cmd.input = :document
  cmd.invoke do |context|    
    require 'ruby_requires'
    require 'insert'
    
    snippet = 'enum_with_index.map { |${1:e}, ${2:i}| $0 }'
    result = insert_at_cursor(STDIN.read, snippet) {|code| RubyRequires.add_requires(code, 'enumerator') }
  end
end
