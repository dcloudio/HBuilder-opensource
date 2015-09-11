require 'ruble'

command 'Go to Definition' do |cmd|
  cmd.input = :document
  cmd.output = :discard
  #cmd.key_binding = 'F3'
  cmd.scope = 'source.ruby'
  cmd.invoke do |context|
    require 'go_to_def'

    GoToDefinition.new($stdin, context.editor.caret_offset).run
    nil
  end
end