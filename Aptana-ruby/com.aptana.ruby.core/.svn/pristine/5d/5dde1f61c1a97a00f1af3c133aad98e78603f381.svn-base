require 'ruble'

command t(:autocomplete_foreign_key_fixture) do |cmd|
  cmd.scope = "source.yaml, source.ruby.rails, meta.rails.unit_test, meta.rails.functional_test"
  cmd.input = :selection, :line
  cmd.output = :insert_as_snippet
  #cmd.key_binding = "M4+ESC"
  cmd.invoke do |context|
    require 'fixture_auto_complete'
    
    filetype, start_line_gap, ref, filter = parse_line
    filter = "" if filter.nil?
    foreign_fixtures = load_referenced_fixture_file(ref, context).keys
    candidates = filter_fixtures(foreign_fixtures, filter)
    if candidates.empty?
      puts t(:no_match_found_for_0, :filter => filter)
      context.exit_show_tool_tip
    end
    selected_fixture = ask_for_fixture_or_exit(candidates, context)
    
    if filetype == :fixture
      print "#{start_line_gap}#{ref}: #{selected_fixture}"
    else
      print "#{start_line_gap}@#{Inflector.singularize ref} = #{ref}(#{symbolize_name selected_fixture})"
    end
    nil
  end
end
