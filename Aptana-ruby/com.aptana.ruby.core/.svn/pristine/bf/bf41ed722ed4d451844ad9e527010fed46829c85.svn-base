require 'ruble'
require 'ruble/terminal'

command t(:run) do |cmd|
  #cmd.key_binding = 'M1+R'
  cmd.scope = 'source.ruby'
  cmd.output = :discard
  cmd.input = :none
  cmd.invoke { Ruble::Terminal.open("ruby -KU -- '#{ENV['TM_FILEPATH']}'", ENV['TM_PROJECT_DIRECTORY']) }
end
