require 'ruble'

with_defaults :scope => "source.ruby.rails.rjs" do |bundle|

  snippet "page.hide (*ids)" do |snippet|
    snippet.trigger = "hide"
    # FIXME We don't support nested tabstops yet
    #snippet.expansion = "page.hide ${1:\"${2:id(s)}\"}"
    snippet.expansion = 'page.hide "${2:id(s)}"'
  end

  snippet "page.insert_html (position, id, partial)" do |snippet|
    snippet.trigger = "ins"
    # FIXME We don't support nested tabstops yet
    #snippet.expansion = "page.insert_html :${1:top}, ${2:\"${3:id}\"}, :${4:partial => \"${5:template}\"}"
    snippet.expansion = 'page.insert_html :${1:top}, "${3:id}", :partial => "${5:template}"'
  end

  snippet "page.replace (id, partial)" do |snippet|
    snippet.trigger = "rep"
    # FIXME We don't support nested tabstops yet
    #snippet.expansion = "page.replace ${1:\"${2:id}\"}, :${3:partial => \"${4:template}\"}"
    snippet.expansion = 'page.replace "${2:id}", :partial => "${4:template}"'
  end

  snippet "page.replace_html (id, partial)" do |snippet|
    snippet.trigger = "reph"
    # FIXME We don't support nested tabstops yet
    #snippet.expansion = "page.replace_html ${1:\"${2:id}\"}, :${3:partial => \"${4:template}\"}"
    snippet.expansion = 'page.replace_html "${2:id}", :partial => "${4:template}"'
  end

  snippet "page.show (*ids)" do |snippet|
    snippet.trigger = "show"
    # FIXME We don't support nested tabstops yet
    #snippet.expansion = "page.show ${1:\"${2:id(s)}\"}"
    snippet.expansion = 'page.show "${2:id(s)}"'
  end

  snippet "page.toggle (*ids)" do |snippet|
    snippet.trigger = "tog"
    # FIXME We don't support nested tabstops yet
    #snippet.expansion = 'page.toggle ${1:"${2:id(s)}"}'
    snippet.expansion = 'page.toggle "${2:id(s)}"'
  end

  snippet "page.visual_effect (effect, id)" do |snippet|
    snippet.trigger = "vis"
    # FIXME We don't support nested tabstops yet
    #snippet.expansion = "page.visual_effect :${1:toggle_slide}, ${2:\"${3:DOM ID}\"}"
    snippet.expansion = 'page.visual_effect :${1:toggle_slide}, "${3:DOM ID}"'
  end

end
