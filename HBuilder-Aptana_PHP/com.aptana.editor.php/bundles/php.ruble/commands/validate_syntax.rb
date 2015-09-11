require 'ruble'

command t(:validate_syntax) do |cmd|
#  cmd.key_binding = 'M4+M2+V'
  cmd.scope = 'source.php'
  cmd.output = :show_as_tooltip
  cmd.input = :document
  cmd.invoke =<<-EOF
#!/usr/bin/env ruby
require ENV['TM_SUPPORT_PATH'] + '/lib/textmate'
version = %x{#{ENV['TM_PHP'] || 'php'} -v}.split[0..2].join(' ')
puts "Running syntax check with " + version + "..."
result = `#{ENV['TM_PHP'] || 'php'} -d display_errors=on -l`
puts result.gsub('in -', '')
TextMate.go_to :line => $1 if result =~ /line (\d+)/
EOF
end
