require 'ruble'

with_defaults :scope => "source.ruby.rails" do |bundle|

  snippet "render (action)" do |snippet|
    snippet.trigger = "ra"
    snippet.expansion = "render :action => '${1:action}'"
  end

  snippet "render (action, layout)" do |snippet|
    snippet.trigger = "ral"
    snippet.expansion = "render :action => '${1:action}', :layout => '${2:layoutname}'"
  end

  snippet "render (file)" do |snippet|
    snippet.trigger = "rf"
    snippet.expansion = "render :file => '${1:filepath}'"
  end

  snippet "render (file, use_full_path)" do |snippet|
    snippet.trigger = "rfu"
    snippet.expansion = "render :file => '${1:filepath}', :use_full_path => ${2:false}"
  end

  snippet "render (inline)" do |snippet|
    snippet.trigger = "ri"
    snippet.expansion = "render :inline => '${1:<%= \"hello\" %>}'"
  end

  snippet "render (inline, locals)" do |snippet|
    snippet.trigger = "ril"
    snippet.expansion = "render :inline => '${1:<%= \"hello\" %>}', :locals => { ${2::name} => '${3:value}'$4 }"
  end

  snippet "render (inline, type)" do |snippet|
    snippet.trigger = "rit"
    snippet.expansion = "render :inline => '${1:<%= \"hello\" %>}', :type => ${2::rxml}"
  end

  snippet "render (layout)" do |snippet|
    snippet.trigger = "rl"
    snippet.expansion = "render :layout => '${1:layoutname}'"
  end

  snippet "render (nothing)" do |snippet|
    snippet.trigger = "rn"
    snippet.expansion = "render :nothing => '${1:true}'"
  end

  snippet "render (nothing, status)" do |snippet|
    snippet.trigger = "rns"
    snippet.expansion = "render :nothing => '${1:true}', :status => ${2:401}"
  end

  snippet "render (partial)" do |snippet|
    snippet.scope = "source.ruby.rails, text.html.ruby, text.haml"
    snippet.trigger = "rp"
    snippet.expansion = "render :partial => '${1:item}'"
  end

  snippet "render (partial, collection)" do |snippet|
    snippet.scope = "source.ruby.rails, text.html.ruby, text.haml"
    snippet.trigger = "rpc"
    # FIXME We don't support tab stop defaulting to value entered in earlier one
    #snippet.expansion = "render :partial => '${1:item}', :collection => ${2:@$1s}"
    snippet.expansion = "render :partial => '${1:item}', :collection => @$1s"
  end

  snippet "render (partial, locals)" do |snippet|
    snippet.scope = "source.ruby.rails, text.html.ruby, text.haml"
    snippet.trigger = "rpl"
    # FIXME We don't support tab stop defaulting to value entered in earlier one
    #snippet.expansion = "render :partial => '${1:item}', :locals => { :${2:$1} => ${3:@$1}$0 }"
    snippet.expansion = "render :partial => '${1:item}', :locals => { :$1 => @${1}$0 }"
  end

  snippet "render (partial, object)" do |snippet|
    snippet.scope = "source.ruby.rails, text.html.ruby, text.haml"
    snippet.trigger = "rpo"
    snippet.expansion = "render :partial => '${1:item}', :object => @$1"
  end

  snippet "render (partial, status)" do |snippet|
    snippet.scope = "source.ruby.rails, text.html.ruby, text.haml"
    snippet.trigger = "rps"
    snippet.expansion = "render :partial => '${1:item}', :status => ${2:500}"
  end

  snippet "render (text)" do |snippet|
    snippet.trigger = "rt"
    snippet.expansion = "render :text => '${1:text to render}'"
  end

  snippet "render (text, layout)" do |snippet|
    snippet.trigger = "rtl"
    snippet.expansion = "render :text => '${1:text to render}', :layout => '${2:layoutname}'"
  end

  snippet "render (text, layout => true)" do |snippet|
    snippet.trigger = "rtlt"
    snippet.expansion = "render :text => '${1:text to render}', :layout => '${2:true}'"
  end

  snippet "render (text, status)" do |snippet|
    snippet.trigger = "rts"
    snippet.expansion = "render :text => '${1:text to render}', :status => ${2:401}"
  end

  snippet "render (update)" do |snippet|
    snippet.trigger = "ru"
    snippet.expansion = "render :update do |${2:page}|\n  $2.$0\nend"
  end

end
