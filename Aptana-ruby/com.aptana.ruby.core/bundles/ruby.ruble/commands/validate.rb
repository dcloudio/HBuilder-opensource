require 'ruble'

command 'Validate' do |cmd|
  cmd.input = :document
  cmd.output = :show_as_tooltip
  cmd.scope = 'source.ruby'
  cmd.invoke do
    compiler_ruby = `which rbx`.strip
    if compiler_ruby.length == 0
      compiler_ruby = ENV['TM_RUBY'] || `which ruby`.strip
    end
    
    result = `#{compiler_ruby} -wc "#{ENV['TM_FILEPATH']}" 2>&1`
    # print result
    # TODO Open editor to busted line
    # TextMate.go_to :line => $1 if result =~ /:(\d+):/
    # nil
  end
end
