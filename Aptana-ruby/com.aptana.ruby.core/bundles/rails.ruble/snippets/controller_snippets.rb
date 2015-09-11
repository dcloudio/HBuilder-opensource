require 'ruble'

with_defaults :scope => "source.ruby, meta.rails.controller" do |bundle|

  snippet "respond_to" do |snippet|
    snippet.trigger = "rest"
    snippet.expansion = "respond_to do |wants|
  wants.${1:html} { $0 \}
end"
  end

  command "respond_to (html)" do |cmd|
    #cmd.key_binding = "M1+SHIFT+H"
    # if selection isn't empty, use it, otherwise use the word containing the current selection
    cmd.input = [ :selection, :word ]
    cmd.output = :insert_as_snippet
    cmd.invoke do |context|
"respond_to do |wants|
  wants.html do
    #{STDIN.read}
  end
  wants.${1:js} { $0 }
end"
    end
  end

  snippet "wants.format" do |snippet|
    snippet.trigger = "wants"
    snippet.expansion = "wants.${1:js/xml/html} { $0 \}"
  end

end
