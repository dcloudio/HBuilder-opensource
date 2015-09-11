require 'ruble'

command 'PStore.new( .. )' do |cmd|
  cmd.trigger = 'Pn'
  cmd.scope = 'source.ruby'
  cmd.output = :insert_as_snippet
  cmd.input = :document
  cmd.invoke do |context|    
    require 'ruby_requires'
    require 'insert'
    
    snippet = 'PStore.new("${1:file_name.pstore}")${0}'
    result = insert_at_cursor(STDIN.read, snippet) {|code| RubyRequires.add_requires(code, 'pstore') }
  end
end
