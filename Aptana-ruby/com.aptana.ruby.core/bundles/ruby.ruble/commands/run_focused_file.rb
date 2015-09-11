require 'ruble'
require 'ruble/terminal'

command t(:run_tests) do |cmd|
  #cmd.key_binding = 'M1+M2+T'
  cmd.scope = 'source.ruby'
  cmd.output = :discard
  cmd.input = :none
  cmd.invoke do
    require 'pathname'
    file_path = ENV['TM_FILEPATH']
    is_test_script = !(file_path.match(/(?:\b|_)(?:tc|ts|test)(?:\b|_)/).nil? and
      file_path.match(/\brequire\b.+(?:test\/unit|test_helper)/).nil?)
    if(is_test_script) 
      project_directory = ENV['TM_PROJECT_DIRECTORY']
      lib_path = File.join(ENV['TM_PROJECT_DIRECTORY'] + 'lib')
      test_path = File.join(ENV['TM_PROJECT_DIRECTORY'] + 'test')
      test_command = ENV['TM_RUBY'] || 'ruby -KU'
      test_command << " -I\"#{lib_path}\" " if File.exist? lib_path
      test_command << " -I\"#{test_path}\" "
      test_command << "\"#{file_path}\""    
      Ruble::Terminal.open(test_command, ENV['TM_PROJECT_DIRECTORY'])
    end
  end
end
