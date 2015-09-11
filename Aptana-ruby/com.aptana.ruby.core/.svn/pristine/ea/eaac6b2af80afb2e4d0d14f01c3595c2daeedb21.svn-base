require 'ruble'

with_defaults :scope => "source.ruby.rails" do |bundle|

  snippet "xhr put" do |snippet|
    snippet.trigger = "xput"
    snippet.expansion = "xhr :put, :${1:update}, :id => ${2:1}, :${3:object} => { $4 }$0"
  end

  snippet "xhr delete" do |snippet|
    snippet.trigger = "xdelete"
    snippet.expansion = "xhr :delete, :${1:destroy}, :id => ${2:1}$0"
  end

  snippet "xhr get" do |snippet|
    snippet.trigger = "xget"
    # FIXME We don't support nested tab stops like this
    #snippet.expansion = "xhr :get, :${1:show}${2:, :id => ${3:1}}$0"
    snippet.expansion = "xhr :get, :${1:show}, :id => ${3:1}$0"
  end

  snippet "xhr post" do |snippet|
    snippet.trigger = "xpost"
    snippet.expansion = "xhr :post, :${1:create}, :${2:object} => { $3 }"
  end

end
