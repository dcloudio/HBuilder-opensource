require 'ruble'

command 'YAML.load(file)' do |cmd|
  cmd.trigger = 'Yl'
  cmd.scope = 'source.ruby'
  cmd.output = :insert_as_snippet
  cmd.input = :document
  cmd.invoke do |context|    
    require 'ruby_requires'
    require 'insert'
    
    snippet = 'File.open("${1:path_to_file}.yaml") { |${2:file}| YAML.load(${2:file}) }${0}'
    result = insert_at_cursor(STDIN.read, snippet) {|code| RubyRequires.add_requires(code, 'yaml') }
  end
end
