require 'ruble'

command 'Benchmark.bmbm do .. end' do |cmd|
  cmd.trigger = 'bm'
  cmd.scope = 'source.ruby'
  cmd.output = :insert_as_snippet
  cmd.input = :document
  cmd.invoke do |context|    
    require 'ruby_requires'
    require 'insert'
    
    snippet = 'TESTS = ${1:10_000}
Benchmark.bmbm do |results|
  $0
end'
    result = insert_at_cursor(STDIN.read, snippet) { |code| RubyRequires.add_requires(code, 'benchmark') }
  end
end
