require 'ruble'

command 'each_slice(..) { |group| .. }' do |cmd|
  cmd.trigger = 'eas'
  cmd.scope = 'source.ruby'
  cmd.output = :insert_as_snippet
  cmd.input = :document
  cmd.invoke do |context|    
    require 'ruby_requires'
    require 'insert'
    
    insert_at_cursor(STDIN.read, 'each_slice(${1:2}) { |${2:group}| $0 }') {|code| RubyRequires.add_requires(code, 'enumerator') }
  end
end
