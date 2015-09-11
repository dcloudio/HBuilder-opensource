require 'ruble'
require 'ruble/ui'
require 'ruble/editor'

require 'rails/rails_path'
require 'rails/text_mate'

### FIX: this file has lots of calls to textmate to do things that have not yet been converted:
#
# TextMate.open_url
# TextMate.exit_discard: exit command invocation with error
# TextMate.rescan_project

class CommandGoToFile
  def self.alternate(args = nil)
    current_file = RailsPath.new

    choice = args.nil? ? current_file.best_match : args

    if choice.nil?
      t(:no_association)
    elsif rails_path = current_file.rails_path_for(choice.to_sym)    
      if !rails_path.exists?
        rails_path, openatline, openatcol = create_file(rails_path, choice.to_sym)
        if rails_path.nil?
          return nil
        end
        Ruble.rescan_project
      end

      Ruble.open rails_path, openatline, openatcol
      nil # Don't show a tooltip
    else
      t(:name_does_not_have_choice, :name => current_file.basename, :choice => choice)
    end
  end  
  
  def self.on_current_line
    current_file = RailsPath.new

    # If the current line contains "render :partial", then open the partial.
    case Ruble.current_line

      # Example: render :partial => 'account/login'
      when /render[\s\(].*:partial\s*=>\s*['"](.+?)['"]/
        partial_name = $1
        modules = current_file.modules + [current_file.controller_name]

        # Check for absolute path to partial
        if partial_name.include?('/')
          pieces = partial_name.split('/')
          partial_name = pieces.pop
          modules = pieces
        end

        ext = current_file.default_extension_for(:view)
        partial = File.join(current_file.rails_root, 'app', 'views', modules, "_#{partial_name}#{ext}")
        Ruble.open(partial)
        nil # Don't show a tooltip
        
      # Example: render :action => 'login'
      when /render[\s\(].*:action\s*=>\s*['"](.+?)['"]/
        action = $1
        if current_file.file_type == :controller
          current_file.buffer.line_number = 0
          if search = current_file.buffer.find { /def\s+#{action}\b/ }
            Ruble.open(current_file, search[0])
            nil # Don't show a tooltip
          end
        else
          return t(:fail_render_outside_controller)
        end

      # Example: redirect_to :action => 'login'
      when /(redirect_to|redirect_back_or_default)[\s\(]/
        controller = action = nil
        controller = $1 if Ruble.current_line =~ /.*:controller\s*=>\s*['"](.+?)['"]/
        action = $1 if Ruble.current_line =~ /.*:action\s*=>\s*['"](.+?)['"]/

        unless current_file.file_type == :controller
          return t(:fail_redirect_outside_controller)
        end

        if controller.nil?
          controller_file = current_file
        else
          # Check for modules
          if controller.include?('/')
            pieces = controller.split('/')
            controller = pieces.pop
            modules = pieces
          end
          other_path = File.join(current_file.rails_root, 'app', 'controllers', modules, "#{controller}_controller.rb")
          controller_file = RailsPath.new(other_path)
        end

        if search = controller_file.buffer.find(:direction => :backward) { /def\s+#{action}\b/ }
          Ruble.open(controller_file, search[0])
          nil # Don't show a tooltip
        else
          return t(:fail_cant_find_action_in_controller, :action => action, :controller => controller_file.basename)
        end

      # Example: <script src="/javascripts/controls.js">
      when /\<script.+src=['"](.+\.js)['"]/
        javascript = $1
        if javascript =~ %r{^https?://}
          Ruble::Editor.open javascript
          nil # Don't show a tooltip
        else
          full_path = File.join(current_file.rails_root, 'public', javascript)
          Ruble.open full_path
          nil # Don't show a tooltip
        end

      # Example: <%= javascript_include_tag 'general' %>
      # require_javascript is used by bundled_resource plugin
      when /(require_javascript|javascript_include_tag)\b/
        if match = Ruble::Editor.current_line.unstringify_hash_arguments.find_nearest_string_or_symbol(Ruble::Editor.column_number)
          javascript = match[0]
          javascript += '.js' if not javascript =~ /\.js$/
          # If there is no leading slash, assume it's a js from the public/javascripts dir
          public_file = javascript[0..0] == "/" ? javascript[1..-1] : "javascripts/#{javascript}"
          Ruble.open File.join(current_file.rails_root, 'public', public_file)
          nil # Don't show a tooltip
        else
          t(:no_javascript_identified)
        end

      # Example: <link href="/stylesheets/application.css">
      # Example: @import url(/stylesheets/conferences.css);
      when /\<link.+href=['"](.+\.css)['"]/, /\@import.+url\((.+\.css)\)/
        stylesheet = $1
        if stylesheet =~ %r{^https?://}
          Ruble::Editor.open stylesheet
          nil # Don't show a tooltip
        else
          full_path = File.join(current_file.rails_root, 'public', stylesheet[1..-1])
          Ruble.open full_path
          nil # Don't show a tooltip
        end

      # Example: <%= stylesheet_link_tag 'application' %>
      when /(require_stylesheet|stylesheet_link_tag)\b/
        if match = Ruble::Editor.current_line.unstringify_hash_arguments.find_nearest_string_or_symbol(Ruble.column_number)
          stylesheet = match[0]
          stylesheet += '.css' if not stylesheet =~ /\.css$/
          # If there is no leading slash, assume it's a js from the public/javascripts dir
          public_file = stylesheet[0..0] == "/" ? stylesheet[1..-1] : "stylesheets/#{stylesheet}"
          Ruble.open File.join(current_file.rails_root, 'public', public_file)
          nil # Don't show a tooltip
        else
          return t(:no_stylesheet_identified)
        end

      else
        t(:no_go_to_file_found)
        # Do nothing -- beep?
    end    
  end
  
  protected
  
  # Returns the rails_path of the newly created file plus the position 
  # (zero based) in the file where to place the caret after opening the 
  # new file. Returns nil when no new file is created.
  def self.create_file(rails_path, choice)       
    return nil if rails_path.exists?
    if choice == :view
      filename = Ruble::UI.request_string(
        :title => t(:view_not_found), 
        :default => rails_path.basename,
        :prompt => t(:enter_name_of_view),
        :button1 => t(:create)
      )
      return nil if !filename
      rails_path = RailsPath.new(File.join(rails_path.dirname, filename))
      rails_path.touch
      return [rails_path, 0, 0]
    end
    
    unless Ruble::UI.request_confirmation(
      :button1 => t(:create),
      :button2 => t(:cancel),
      :title => t(:missing_name, :name => rails_path.basename),
      :prompt => t(:create_missing_name, :name => rails_path.basename)
    )
      return nil
    end

    generated_code, openatline, openatcol = case choice
    when :model
      ["class #{Inflector.singularize rails_path.controller_name.camelize} < ActiveRecord::Base\n\nend", 1, 0]
    when :controller 
      ["class #{rails_path.controller_name.camelize}Controller < ApplicationController\n\nend", 1, 0]
    when :helper
      ["module #{rails_path.controller_name.camelize}Helper\n\nend", 1, 0]
    when :unit_test
      ["require File.dirname(__FILE__) + '/../test_helper'

class #{Inflector.singularize(rails_path.controller_name).camelize}Test < ActiveSupport::TestCase
 # Replace this with your real tests.
 def test_truth
   assert true
 end
end", 3, 0]   
    when :functional_test
      ["require File.dirname(__FILE__) + '/../test_helper'

class #{rails_path.controller_name.camelize}ControllerTest < ActionController::TestCase     

end", 3, 0]
    end
    # TODO Add fxixture, stylesheet to case with default content?

    rails_path.touch
    rails_path.append generated_code if generated_code
    return [rails_path, openatline, openatcol]
  end
    
end