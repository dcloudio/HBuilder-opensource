require 'ruble'
require 'ruble/terminal'

command t(:run_focused_test) do |cmd|
  #cmd.key_binding = 'M1+M2+R'
  cmd.scope = 'source.ruby'
  cmd.output = :discard
  cmd.input = :none
  cmd.invoke do |context|
    require 'pathname'
    args = [ ]
    n = ENV['TM_LINE_NUMBER'].to_i

    spec, context, name, test_name = nil, nil, nil
  
    File.open(ENV['TM_FILEPATH']) do |f|
      # test/unit
      lines     = f.read.split("\n")[0...n].reverse
      name      = lines.find { |line| line =~ /^\s*def test[_a-z0-9]*[\?!]?/i }.to_s.sub(/^\s*def (.*?)\s*$/) { $1 }
      # test helper
      test_name = $2 || $3 if lines.find { |line| line =~ /^\s*test\s+('(.*)'|"(.*)")+\s*(\{|do)/ }
      # test/spec.
      spec      = $3 || $4 if lines.find { |line| line =~ /^\s*(specify|it)\s+('(.*)'|"(.*)")+\s*(\{|do)/ }
      context   = $3 || $4 if lines.find { |line| line =~ /^\s*(context|describe)\s+('(.*)'|"(.*)")+\s*(\{|do)/ }
    end
  
    if name and !name.empty?
      args << "--name=#{name}"
    elsif test_name and !test_name.empty?
      args << "--name=test_#{test_name.gsub(/\s+/,'_')}"
    elsif spec and !spec.empty? and context and !context.empty?
      args << %Q{--name="/test_spec \\{.*#{context}\\} \\d{3} \\[#{spec}\\]/"}
    else
      # Show an error dialog
      title = "Error!!"
      summary = "This doesn't appear to be a TestCase or spec.\nMake sure a TestCase or spec is focused to use this command."
      Ruble::UI.alert(:error, title, summary)
      exit
      # Alternatively, we could just show a tooltip for the error and bail...
      # context.exit_show_tool_tip(title + "\n\n" + summary)
    end
    
    is_test_script = !(ENV["TM_FILEPATH"].match(/(?:\b|_)(?:tc|ts|test)(?:\b|_)/).nil? and
    File.read(ENV["TM_FILEPATH"]).match(/\brequire\b.+(?:test\/unit|test_helper)/).nil?)
  
    cmd = [ENV['TM_RUBY'] || 'ruby', '-KU']
    
    if is_test_script and not ENV['TM_FILE_IS_UNTITLED']
      path_ary = (ENV['TM_ORIG_FILEPATH'] || ENV['TM_FILEPATH']).split("/")
      if index = path_ary.rindex("test")
        test_path = "#{File.join(*path_ary[0..index])}:#{File.join(*path_ary[0..-2])}"
        lib_path  = File.join( *( path_ary[0..-2] +
                                  [".."] * (path_ary.length - index - 1) ) +
                                  ["lib"] )
        if File.exist? lib_path
          cmd << "-I#{lib_path}:#{test_path}"
        else
          cmd << "-I#{test_path}"
        end
      end
    end
    
    cmd << ENV["TM_FILEPATH"]
    cmd_line = "\"#{cmd.join('" "')}\" "
    cmd_line << "\"#{args.join('" "')}\""
    Ruble::Terminal.open(cmd_line, ENV['TM_PROJECT_DIRECTORY'])
  end
end
