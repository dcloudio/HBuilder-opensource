require 'ruble'

command t(:show_db_schema_for_class) do |cmd|
  #cmd.key_binding = "CONTROL+SHIFT+COMMAND+S"
  cmd.input = :none
  cmd.output = :show_as_tooltip
  cmd.scope = "source.ruby, text.html.ruby, source.ruby.rails.embedded.html, meta.rails.helper, meta.rails.functional_test, source.js, source.css, source.yaml, meta.rails.model, meta.rails.unit_test, text.haml"
  cmd.invoke do |context|
    # FIXME check for ruby exes in path
    ruby_exe = ENV['TM_RUBY'] || 'ruby'
    Dir.chdir(ENV['TM_PROJECT_DIRECTORY']) # run from root of project
    cmd_line = "#{ruby_exe} \"#{ENV['TM_BUNDLE_SUPPORT']}/../assets/bin/schema.rb\" \"#{ENV['TM_PROJECT_DIRECTORY']}\" \"#{ENV['TM_CURRENT_WORD']}\""
    IO.popen(cmd_line, 'r') {|io| io.read }
  end
end
