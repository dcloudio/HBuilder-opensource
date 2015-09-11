require 'ruble'

with_defaults :scope =>  'source.ruby.rails' do |bundle|

snippet 'alias_attribute' do |s|
  s.trigger = 'alias'
  s.expansion = 'alias_attribute :${1:new_name}, :${2:old_name}'
end

snippet 'cattr_accessor' do |s|
  s.trigger = 'crw'
  s.expansion = 'cattr_accessor :${1:attr_names}'
end

snippet 'config.gem' do |s|
  s.trigger = 'config.gem'
  # FIXME We don't support nested tab stops yet
  #s.expansion = 'config.gem "${1:name}"${2:, :lib => ${3:"${4:$1}"}}${5:, :version => "${6:>= 1.0.0}"}${7:, :source => "${8:http://gemcutter.org}"}'
  s.expansion = 'config.gem "${1:name}", :lib => "${1}", :version => "${6:>= 1.0.0}", :source => "${8:http://gemcutter.org}"'
end

snippet 'content_for' do |s|
  s.trigger = 'conf'
  s.scope = 'text.html.ruby'
  s.expansion = '<% content_for :${1:yield_label_in_layout} do -%>
	$0
<% end -%>'
end

snippet t(:create_controller) do |s|
  s.trigger = 'cla'
  s.scope = 'source.ruby'
  s.expansion = 'class ${1:Model}Controller < ApplicationController
	before_filter :find_${2:model}

	$0

	private
	def find_${2}
		@$2 = $1.find(params[:id]) if params[:id]
	end
end'
end

snippet t(:create_functional_test_class) do |s|
  s.trigger = 'cla'
  s.scope = 'source.ruby'
  s.expansion = 'require File.dirname(__FILE__) + \'/../test_helper\'

class ${1:Model}ControllerTest < ActionController::TestCase
	deft$0
end
'
end

snippet t(:create_resources_controller) do |s|
  s.trigger = 'resources'
  s.scope = 'source.ruby'
  # FIXME We don't support transformations yet
#  s.expansion = 'class ${1:Model}sController < ApplicationController
#  before_filter :find_${1/./\l$0/}, :only => [:show, :edit, :update, :destroy]
#
#  # GET /${1/./\l$0/}s
#  # GET /${1/./\l$0/}s.xml
#  def index
#    @${1/./\l$0/}s = ${1:Model}.all
#
#    respond_to do |wants|
#      wants.html # index.html.erb
#      wants.xml  { render :xml => @${1/./\l$0/}s }
#    end
#  end
#
#  # GET /${1/./\l$0/}s/1
#  # GET /${1/./\l$0/}s/1.xml
#  def show
#    respond_to do |wants|
#      wants.html # show.html.erb
#      wants.xml  { render :xml => @${1/./\l$0/} }
#    end
#  end
#
#  # GET /${1/./\l$0/}s/new
#  # GET /${1/./\l$0/}s/new.xml
#  def new
#    @${1/./\l$0/} = ${1:Model}.new
#
#    respond_to do |wants|
#      wants.html # new.html.erb
#      wants.xml  { render :xml => @${1/./\l$0/} }
#    end
#  end
#
#  # GET /${1/./\l$0/}s/1/edit
#  def edit
#  end
#
#  # POST /${1/./\l$0/}s
#  # POST /${1/./\l$0/}s.xml
#  def create
#    @${1/./\l$0/} = ${1:Model}.new(params[:${1/./\l$0/}])
#
#    respond_to do |wants|
#      if @${1/./\l$0/}.save
#        flash[:notice] = \'${1:Model} was successfully created.\'
#        wants.html { redirect_to(@${1/./\l$0/}) }
#        wants.xml  { render :xml => @${1/./\l$0/}, :status => :created, :location => @${1/./\l$0/} }
#      else
#        wants.html { render :action => "new" }
#        wants.xml  { render :xml => @${1/./\l$0/}.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /${1/./\l$0/}s/1
#  # PUT /${1/./\l$0/}s/1.xml
#  def update
#    respond_to do |wants|
#      if @${1/./\l$0/}.update_attributes(params[:${1/./\l$0/}])
#        flash[:notice] = \'${1:Model} was successfully updated.\'
#        wants.html { redirect_to(@${1/./\l$0/}) }
#        wants.xml  { head :ok }
#      else
#        wants.html { render :action => "edit" }
#        wants.xml  { render :xml => @${1/./\l$0/}.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /${1/./\l$0/}s/1
#  # DELETE /${1/./\l$0/}s/1.xml
#  def destroy
#    @${1/./\l$0/}.destroy
#
#    respond_to do |wants|
#      wants.html { redirect_to(${1/./\l$0/}s_url) }
#      wants.xml  { head :ok }
#    end
#  end
#
#  private
#    def find_${1/./\l$0/}
#      @${1/./\l$0/} = ${1:Model}.find(params[:id])
#    end
#
#end
#'
s.expansion = 'class ${1:Model}sController < ApplicationController
  before_filter :find_${1}, :only => [:show, :edit, :update, :destroy]

  # GET \/${1}s
  # GET \/${1}s.xml
  def index
    @${1}s = ${1:Model}.all

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @${1}s }
    end
  end

  # GET \/${1}s\/1
  # GET \/${1}s\/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @${1} }
    end
  end

  # GET \/${1}s\/new
  # GET \/${1}s\/new.xml
  def new
    @${1} = ${1:Model}.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @${1} }
    end
  end

  # GET \/${1}s\/1\/edit
  def edit
  end

  # POST \/${1}s
  # POST \/${1}s.xml
  def create
    @${1} = ${1:Model}.new(params[:${1}])

    respond_to do |wants|
      if @${1}.save
        flash[:notice] = \'${1:Model} was successfully created.\'
        wants.html { redirect_to(@${1}) }
        wants.xml  { render :xml => @${1}, :status => :created, :location => @${1} }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @${1}.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT \/${1}s\/1
  # PUT \/${1}s\/1.xml
  def update
    respond_to do |wants|
      if @${1}.update_attributes(params[:${1}])
        flash[:notice] = \'${1:Model} was successfully updated.\'
        wants.html { redirect_to(@${1}) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @${1}.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE \/${1}s\/1
  # DELETE \/${1}s\/1.xml
  def destroy
    @${1}.destroy

    respond_to do |wants|
      wants.html { redirect_to(${1}s_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_${1}
      @${1} = ${1:Model}.find(params[:id])
    end

end
'
end

snippet t(:sweeper) do |s|
  s.trigger = 'sweeper'
  # FIXME We don't support transformations yet
#  s.expansion = 'class ${1:Model}Sweeper < ActionController::Caching::Sweeper
#  observe ${1:Model}
#
#  def after_save(${1/./\l$0/})
#    expire_cache(${1/./\l$0/})
#  end
#
#  def after_destroy(${1/./\l$0/})
#    expire_cache(${1/./\l$0/})
#  end
#
#  private
#
#    def expire_cache(${1/./\l$0/})
#      ${0:expire_page ${1/./\l$0/}s_path 
#      expire_page ${1/./\l$0/}_path(${1/./\l$0/})}
#    end
#
#end'
  s.expansion = 'class ${1:Model}Sweeper < ActionController::Caching::Sweeper
  observe ${1:Model}

  def after_save(${1})
    expire_cache(${1})
  end

  def after_destroy(${1})
    expire_cache(${1})
  end

  private

    def expire_cache(${1})
      expire_page ${1}s_path 
      expire_page ${1}_path(${1})
    end

end'
end

snippet 'def create - resource' do |s|
  s.trigger = 'defcreate'
  # FIXME We don't support meta scopes
  s.scope = 'meta.rails.controller'
  # FIXME We don't support transformations yet
#  s.expansion = 'def create
#	@${1:model} = ${2:${1/[[:alpha:]]+|(_)/(?1::\u$0)/g}}.new(params[:$1])
#	$0
#	respond_to do |wants|
#		if @$1.save
#			flash[:notice] = \'$2 was successfully created.\'
#			wants.html { redirect_to(@$1) }
#			wants.xml { render :xml => @$1, :status => :created, :location => @$1 }
#		else
#			wants.html { render :action => "new" }
#			wants.xml { render :xml => @$1.errors, :status => :unprocessable_entity }
#		end
#	end
#end
#'
  s.expansion = 'def create
  @${1:model} = ${2}.new(params[:$1])
  $0
  respond_to do |wants|
    if @$1.save
      flash[:notice] = \'$2 was successfully created.\'
      wants.html { redirect_to(@$1) }
      wants.xml { render :xml => @$1, :status => :created, :location => @$1 }
    else
      wants.html { render :action => "new" }
      wants.xml { render :xml => @$1.errors, :status => :unprocessable_entity }
    end
  end
end
'
end

snippet 'def test_should_get_action' do |s|
  s.trigger = 'deftg'
  # FIXME We don't support meta scopes
  s.scope = 'meta.rails.functional_test'
  # FIXME We don't support nested tab stops
#  s.expansion = 'def test_should_get_${1:action}
#	${2:@${3:model} = ${4:$3s}(:${5:fixture_name})
#	}get :${1}${6:, :id => @$3.to_param}
#	assert_response :success
#	$0
#end'
s.expansion = 'def test_should_get_${1:action}
  @${3:model} = $3s(:${5:fixture_name})
  get :${1}, :id => @$3.to_param
  assert_response :success
  $0
end'
end

snippet 'def test_should_post_action' do |s|
  s.trigger = 'deftp'
  # FIXME We don't support meta scopes
  s.scope = 'meta.rails.functional_test'
  # FIXME We don't support nested tab stops
#  s.expansion = 'def test_should_post_${1:action}
#	${3:@$2 = ${4:$2s}(:${5:fixture_name})
#	}post :${1}${6:, :id => @$2.to_param}, :${2:model} => { $0 }
#	assert_response :redirect
#
#end'
  s.expansion = 'def test_should_post_${1:action}
  @${2:model} = ${2:model}s(:${5:fixture_name})
  post :${1}, :id => @${2:model}.to_param, :${2:model} => { $0 }
  assert_response :redirect

end'
end

snippet 'default_scope' do |s|
  s.trigger = 'dc'
  # FIXME We don't support nested tab stops
  #s.expansion = 'default_scope :${1:order} => ${2:\'created_at DESC\'}${3:, :joins => :${4:table}}'
  s.expansion = 'default_scope :${1:order} => \'created_at DESC\', :joins => :${2:table}'
end

snippet 'end (ERB)' do |s|
  s.trigger = 'end'
  s.scope = 'text.html.ruby'
  s.expansion = '<% end -%>'
end

snippet t(:for_loop_rhtml) do |s|
  s.trigger = 'for'
  s.scope = 'text.html.ruby'
  s.expansion = '<% if !${1:list}.blank? %>
  <% for ${2:item} in ${1} %>
    $3
  <% end %>
<% else %>
  $4
<% end %>
'
end

snippet 'layout' do |s|
  s.trigger = 'layout'
  # FIXME We don't support nested tab stops
  #s.expansion = 'layout "${1:template_name}"${2:${3:, :only => ${4:[:${5:action}, :${6:action}]}}${7:, :except => ${8:[:${9:action}, :${10:action}]}}}'
  s.expansion = 'layout "${1:template_name}", :only => [:${2:action}, :${3:action}], :except => [:${4:action}, :${5:action}]'
end

snippet 'map(&:sym_proc)' do |s|
  s.trigger = 'mp'
  s.expansion = 'map(&:${1:id})'
end

snippet 'mattr_accessor' do |s|
  s.trigger = 'mrw'
  s.expansion = 'mattr_accessor :${1:attr_names}'
end

snippet 'named_scope lambda' do |s|
  s.trigger = 'ncl'
  # FIXME We don't support nested tab stops
#  s.expansion = 'named_scope :${1:name}, lambda { |${2:param}| { :conditions => ${3:[\'${4:${5:field} = ?}\', ${6:$2}]} } }
#'
  s.expansion = 'named_scope :${1:name}, lambda { |${2:param}| { :conditions => [\'${5:field} = ?\', $2] } }\n'
end

snippet 'named_scope' do |s|
  s.trigger = 'nc'
  # FIXME We don't support nested tab stops
#  s.expansion = 'named_scope :${1:name}${2:, :joins => :${3:table}}, :conditions => ${4:[\'${5:${6:field} = ?}\', ${7:true}]}
#'
  s.expansion = 'named_scope :${1:name}, :joins => :${3:table}, :conditions => [\'${6:field} = ?\', ${7:true}]\n'
end

snippet 'flash[...]' do |s|
  s.trigger = 'flash'
  s.expansion = 'flash[:${1:notice}] = "${2:Successfully created...}"$0'
end

# FIXME Keybinding isn't working!
snippet 'params[...]' do |s|
  #s.key_binding = 'CTRL+P'
  s.expansion = 'params[:${1:id}]'
end

# FIXME Keybinding isn't working!
snippet 'session[...]' do |s|
  #s.key_binding = 'CTRL+J'
  s.expansion = 'session[:${1:user}]'
end

snippet 'returning do |variable| ... end' do |s|
  s.trigger = 'returning'
  # FIXME We don't support transformations
#  s.expansion = 'returning ${1:variable} do${2/(^(?<var>\s*[a-z_][a-zA-Z0-9_]*\s*)(,\g<var>)*,?\s*$)|.*/(?1: |)/}${2:v}${2/(^(?<var>\s*[a-z_][a-zA-Z0-9_]*\s*)(,\g<var>)*,?\s*$)|.*/(?1:|)/}
#	$0
#end'
  s.expansion = 'returning ${1:variable} do |${2:v}|
  $0
end'
end

snippet 'scoped_by' do |s|
  s.trigger = 'sb'
  s.expansion = 'scoped_by_${1:attribute}(${2:id})'
end

snippet 'stylesheet_link_tag' do |s|
  s.trigger = 'slt'
  s.scope = 'text.html.ruby, text.haml'
  # FIXME We don't support nested tab stops
  #s.expansion = '${TM_RAILS_TEMPLATE_START_RUBY_EXPR}stylesheet_link_tag ${1::all}${2:, :cache => ${3:true}}$TM_RAILS_TEMPLATE_END_RUBY_EXPR'
  s.expansion = '${TM_RAILS_TEMPLATE_START_RUBY_EXPR}stylesheet_link_tag ${1::all}, :cache => ${3:true}$TM_RAILS_TEMPLATE_END_RUBY_EXPR'
end

snippet 'submit_tag' do |s|
  s.trigger = 'st'
  s.scope = 'text.html.ruby, text.haml'
  # FIXME We don't support nested tab stops
  #s.expansion = '${TM_RAILS_TEMPLATE_START_RUBY_EXPR}submit_tag \"${1:Save changes}\"${2:, :id => \"${3:submit}\"}${4:, :name => \"${5:$3}\"}${6:, :class => \"${7:form_$3}\"}${8:, :disabled => ${9:false}}${10:, :disable_with => \"${11:Please wait...}\"}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}'
  s.expansion = '${TM_RAILS_TEMPLATE_START_RUBY_EXPR}submit_tag "${1:Save changes}", :id => "${3:submit}", :name => "$3", :class => "${7:form_}$3", :disabled => ${9:false}, :disable_with => "${11:Please wait...}"${TM_RAILS_TEMPLATE_END_RUBY_EXPR}'
end

snippet 'image_submit_tag' do |s|
  s.trigger = 'ist'
  s.scope = 'text.html.ruby, text.haml'
  # FIXME We don't support nested tab stops or transformations!
  #s.expansion = '${TM_RAILS_TEMPLATE_START_RUBY_EXPR}image_submit_tag(\"${1:agree.png}\"${2:${3:, :id => \"${4:${1/^(\w+)(\.\w*)?$/$1/}}\"}${5:, :name => \"${6:${1/^(\w+)(\.\w*)?$/$1/}}\"}${7:, :class => \"${8:${1/^(\w+)(\.\w*)?$/$1/}-button}\"}${9:, :disabled => ${10:false}}})${TM_RAILS_TEMPLATE_END_RUBY_EXPR}'
  s.expansion = '${TM_RAILS_TEMPLATE_START_RUBY_EXPR}image_submit_tag("${1:agree}.${2:png}", :id => "${1}", :name => "${1}", :class => "${1}-button", :disabled => ${10:false})${TM_RAILS_TEMPLATE_END_RUBY_EXPR}'
end

snippet 'javascript_include_tag' do |s|
  s.trigger = 'jit'
  s.scope = 'text.html.ruby, text.haml'
  # FIXME We don't support nested tab stops
  #s.expansion = '${TM_RAILS_TEMPLATE_START_RUBY_EXPR}javascript_include_tag ${1::all}${2:, :cache => ${3:true}}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}'
  s.expansion = '${TM_RAILS_TEMPLATE_START_RUBY_EXPR}javascript_include_tag ${1::all}, :cache => ${3:true}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}'
end

end