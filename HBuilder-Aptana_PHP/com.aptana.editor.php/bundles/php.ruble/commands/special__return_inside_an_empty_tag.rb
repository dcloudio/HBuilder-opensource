require 'ruble'

command 'Special: Return Inside an Empty Tag' do |cmd|
  cmd.key_binding = 'ENTER'
  cmd.scope = 'source.php.embedded.line.empty.html source.php'
  cmd.output = :insert_as_snippet
  cmd.input = :selection, :scope
  cmd.invoke =<<-EOF
exit_insert_snippet "
\$0
?"
EOF
end
