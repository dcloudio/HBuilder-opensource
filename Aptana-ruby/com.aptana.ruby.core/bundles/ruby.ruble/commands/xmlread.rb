require 'ruble'

command 'xmlread(..)' do |cmd|
  cmd.trigger = 'xml'
  cmd.scope = 'source.ruby'
  cmd.output = :insert_as_snippet
  cmd.input = :document
  cmd.invoke do |context|    
    require 'ruby_requires'
    require 'insert'
    
    snippet = 'REXML::Document.new(File.read("${1:path_to_file}"))${0}'
    result = insert_at_cursor(STDIN.read, snippet) { |code| RubyRequires.add_requires(code, 'rexml/document') }
  end
end
