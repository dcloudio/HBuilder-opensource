require 'rails_bundle_tools'

def parse_line
  current_line = Ruble.current_line
  if RailsPath.new.file_type == :fixture
    if fixture_finder = current_line.match(/^([\s\t]+)\b([a-z_]+)\:([a-z_]*)/)
      [:fixture] + fixture_finder[1..3]
    end
  else
    if fixture_finder = current_line.match(/^([\s\t]+).*\b([a-z_]+)\(\:([a-z_]*)\)/)
      [:test] + fixture_finder[1..3]
    end
  end
end

require 'yaml'
def load_referenced_fixture_file(ref, context)
  ref_plural = Inflector.pluralize(ref)
  ref_file = File.join(Ruble.project_directory, "test", "fixtures", "#{ref_plural}.yml")
  if (!File.exist?(ref_file))
    ref_file = File.join(Ruble.project_directory, "spec", "fixtures", "#{ref_plural}.yml")
  end
  if (!File.exist?(ref_file))
    puts "Could not find any #{ref} fixtures."
    context.exit_show_tool_tip
  end  
  YAML.load_file(ref_file)
end

require 'ruble/ui'
def ask_for_fixture_or_exit(fixtures, context)
  index = Ruble::UI.menu(fixtures)
  context.exit_discard unless index
  fixtures[index]
end

def filter_fixtures(fixtures, filter, preserve = false)
  if !filter.empty? && !preserve
    fixtures.select do |f|
      f.include? filter
    end
  else
    fixtures
  end
end

# 'foo' => ':foo' and 'foo-bar' => ':"foo-bar"'
def symbolize_name(name)
  name.to_sym.inspect
end