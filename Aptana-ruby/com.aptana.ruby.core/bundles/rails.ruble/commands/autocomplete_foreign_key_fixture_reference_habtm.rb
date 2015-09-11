require 'ruble'

command t(:autocomplete_foreign_key_fixture_1) do |cmd|
  cmd.scope = "source.yaml"
  cmd.input = :selection, :line
  cmd.output = :insert_as_snippet
  #cmd.key_binding = "M4+M2+ESC"
  cmd.invoke do |context|
    require 'fixture_auto_complete'
    
    filetype, start_line_gap, ref, filter = parse_line
    filter = "" if filter.nil?
    foreign_fixtures = load_referenced_fixture_file(ref, context).keys
    candidates = filter_fixtures(foreign_fixtures, filter, true)
    if candidates.empty?
      puts t(:no_match_found_for_0, :filter => filter)
      context.exit_show_tool_tip
    end
    selected_fixture = ask_for_fixture_or_exit(candidates, context)
    
    print Ruble.current_line.rstrip
    if !filter.empty?
      print ", "
    else
      print " "
    end
    print selected_fixture
    nil
  end
end
