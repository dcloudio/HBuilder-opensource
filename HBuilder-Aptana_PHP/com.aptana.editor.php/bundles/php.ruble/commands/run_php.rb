require 'ruble'

command t(:run) do |cmd|
#  cmd.key_binding = 'M1+M2+R'
  cmd.scope = 'source.php'
  cmd.output = :show_as_html
  cmd.input = :document
  cmd.invoke =<<-EOF
#!/bin/sh
/usr/bin/env ruby -- "$TM_BUNDLE_SUPPORT/lib/php_mate.rb"
EOF
end
