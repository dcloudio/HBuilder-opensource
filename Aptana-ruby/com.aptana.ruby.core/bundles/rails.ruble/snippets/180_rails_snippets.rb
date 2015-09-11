require 'ruble'

snippet "form_tag" do |snippet|
  snippet.trigger = "ft"
  # FIXME We don't support nested tab stops, below is original snippet
  #snippet.expansion = "form_tag(${1::action => \"${5:update}\"}${6:, {:${8:class} => \"${9:form}\"}}) do\n\t$0\n"
  snippet.expansion = "form_tag(:action => \"${1:update}\", {:${2:class} => \"${3:form}\"}) do\n\t$0\n"
  snippet.scope = [ :text_html_ruby, :text_haml ]
end
