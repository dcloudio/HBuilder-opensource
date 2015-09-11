require 'ruble'

command t(:execute_and_update_hash_markers) do |cmd|
  #cmd.key_binding = 'COMMAND+CONTROL+SHIFT+E'
  cmd.scope = 'source.ruby'
  cmd.output = :replace_selection
  cmd.input = :selection, :document
  cmd.invoke do |context|
    cmd_line = "ruby -r \"#{ENV['TM_BUNDLE_SUPPORT']}/add_1.8_features.rb\" -I \"#{ENV['TM_BUNDLE_SUPPORT']}/vendor/rcodetools/lib\" -- \"#{ENV['TM_BUNDLE_SUPPORT']}/vendor/rcodetools/bin/xmpfilter\""
    result = IO.popen(cmd_line, "r+") do |io|
      io.write STDIN.read
      io.close_write # let the process know you've given it all the data 
      io.read
    end    
  end
end
