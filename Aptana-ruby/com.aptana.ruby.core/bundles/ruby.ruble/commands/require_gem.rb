require 'ruble'

command 'require_gem ".."' do |cmd|
  cmd.trigger = 'reqg'
  cmd.scope = 'source.ruby'
  cmd.output = :insert_as_snippet
  cmd.input = :document
  cmd.invoke do |context|    
    require 'ruby_requires'
    require 'insert'
    
    snippet = 'require "$0"'
    result = insert_at_cursor(STDIN.read, snippet) {|code| RubyRequires.add_requires(code, 'rubygems') }
  end
end
