require 'ruble'

command 'Extend Forwardable (Forw)' do |cmd|
  cmd.trigger = 'Forw'
  cmd.scope = 'source.ruby'
  cmd.output = :insert_as_snippet
  cmd.input = :document
  cmd.invoke do |context|
    require 'ruby_requires'
    require 'insert'
    
    insert_at_cursor(STDIN.read, '${0}extend Forwardable') {|code| RubyRequires.add_requires(code, 'forwardable') }
  end
end
