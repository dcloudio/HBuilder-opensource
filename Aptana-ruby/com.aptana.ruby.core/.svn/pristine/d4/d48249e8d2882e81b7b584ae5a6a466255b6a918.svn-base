require 'ruble'

command t(:check_syntax) do |cmd|
  #cmd.key_binding = 'M2+M4+V'
  cmd.scope = 'text.haml'
  cmd.output = :show_as_tooltip
  cmd.input = :none
  cmd.invoke do |context|
    # TODO Check syntax against file contents, so we pick up unsaved changes!
    context.exit_show_tool_tip('File not found') unless File.exists?(ENV['TM_FILEPATH'])
    
    result = IO.popen("haml -c '#{ENV['TM_FILEPATH']}' 2>&1") {|io| io.read }
    if result.nil? or result.strip.length == 0
      "No output from 'haml'. Please be sure the haml and hpricot gems are installed. On windows, hpricot needs to be installed via Ruby DevKit's MSYS prompt."
    else
      result
    end
  end
end
