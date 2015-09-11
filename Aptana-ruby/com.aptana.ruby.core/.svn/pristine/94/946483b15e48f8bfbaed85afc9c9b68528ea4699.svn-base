require 'ruble'

command 'YAML.dump(.., file)' do |cmd|
  cmd.trigger = 'Yd'
  cmd.scope = 'source.ruby'
  cmd.output = :insert_as_snippet
  cmd.input = :document
  cmd.invoke do |context|
    require 'ruby_requires'
    require 'insert'
    
    snippet = 'File.open("${1:path_to_file}.yaml", "w") { |${2:file}| YAML.dump(${3:obj}, ${2:file}) }${0}'
    insert_at_cursor(STDIN.read, snippet) {|code| RubyRequires.add_requires(code, 'yaml') }
  end
end
