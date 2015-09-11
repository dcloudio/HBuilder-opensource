require 'ruble'
require 'ruble/ui'

command 'word_wrap()' do |cmd|
  cmd.scope = 'source.ruby'
  cmd.output = :insert_as_text
  cmd.input = :none
  cmd.trigger = "worw" #FIXME In text mate this prefix will get replaced, but we don't seem to replace
  cmd.invoke do |context|
    options = { :title => "Wrap Size", :prompt => "Enter a character width:", :button1 => "Build Snippet" }
    Ruble::UI.request_string(options) do |col|
      col = col.to_i
      %Q{gsub!(/(.{1,#{col}}|\\S{#{col + 1},})(?: +|$\\n?)/, "\\\\1\\n")}
    end
  end
end
