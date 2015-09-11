require 'ruble'

command t(:execute_as_ruby) do |cmd|
  #cmd.key_binding = 'Shift+Control+E'
  cmd.output = :insert_as_text
  cmd.input = :selection, :line
  cmd.invoke do |context|
    # We don't want to execute this in the JRuby process, we'll need to write thise code out to a file, 
    # run it with ruby as a command, pipe the input and then return the result
code =<<EOF
    # be smart, dont print something if we already have..
    $write_count = 0
    def STDOUT.write(what)
       $write_count += 1
       super(what)
    end
    
    # execute the code
    begin
      # insert a space if input was a selection, if it was a line insert \n
      print(ARGV[0] == 'selection' ? " " : "\n")
      r = eval(STDIN.read)
    rescue Object
      r = $!.class.to_s
    end
    
    # try to_s, if it doesnt work use inspect
    # Array and Hash are shown via inspect because they look better with formatting
    # do this just if the script did not print anything itself
    if $write_count == 1
      print( (r.class != Hash and r.class != Array and not r.nil? and r.respond_to? :to_s) ? r.to_s : r.inspect )
      print( "\n" ) unless ARGV[0] == 'selection'
    end
EOF
    # Write code to a temp file
    require 'tempfile'
    tmp = Tempfile.new('fred')
    tmp << code
    tmp.flush
    tmp.close
    # popen a ruby process running the tempfile and grab the result
    result = IO.popen("ruby \"#{tmp.path}\" #{context.input_type.downcase} 2>&1", "r+") do |io|
      io.write STDIN.read
      io.close_write # let the process know you've given it all the data 
      io.read
    end
  end
end
