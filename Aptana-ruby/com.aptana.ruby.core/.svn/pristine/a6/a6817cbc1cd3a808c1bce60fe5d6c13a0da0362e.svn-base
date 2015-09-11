# Copyright:
#   (c) 2006 syncPEOPLE, LLC.
#   Visit us at http://syncpeople.com/
# Author: Duane Johnson (duane.johnson@gmail.com)
# Description:
#   Creates a partial from the selected text (asks for the partial name)
#   and replaces the text with a "render :partial => [partial_name]" erb fragment.
require 'ruble'
require 'ruble/ui'

command t(:create_partial) do |cmd|
  cmd.scope = "source.ruby.rails, text.html.ruby, text.haml"
  cmd.output = :replace_selection
  cmd.input = :selection, :line
  #cmd.key_binding = "M4+H"
  cmd.invoke do |context|
    require 'rails_bundle_tools'
    
    current_file = RailsPath.new
    
    # Make sure we're in a view file
    unless current_file.file_type == :view
      context.exit_show_tool_tip t(:create_partial_outside_view, :command_name => t(:create_partial))
    end
    
    # If text is selected, create a partial out of it
    if Ruble.selected_text
      partial_name = Ruble::UI.request_string(
        :title => t(:create_partial_from_selection_title),
        :default => "partial",
        :prompt => t(:create_partial_from_selection_prompt),
        :button1 => t(:create)
      )
    
      if partial_name
        path = current_file.dirname
        partial = File.join(path, "_#{partial_name}.html.erb")
    
        # Create the partial file
        if File.exist?(partial)
          unless Ruble::UI.request_confirmation(
            :button1 => t(:overwrite),
            :button2 => t(:cancel),
            :title => t(:partial_already_exists),
            :prompt => t(:overwrite_it)
          )
            context.exit_discard
          end
        end
    
        file = File.open(partial, "w") { |f| f.write(Ruble.selected_text) }
        Ruble.rescan_project
    
        # Return the new render :partial line
        print "<%= render :partial => '#{partial_name}' %>\n"
      else
        context.exit_discard
      end
    else
      # Otherwise, toggle inline partials if they exist
    
      text = ""
      partial_block_re =
        /<!--\s*\[\[\s*Partial\s'(.+?)'\sBegin\s*\]\]\s*-->\n(.+)<!--\s*\[\[\s*Partial\s'\1'\sEnd\s*\]\]\s*-->\n/m
    
      # Inline partials exist?
      if current_file.buffer =~ partial_block_re
        text = current_file.buffer.text
        while text =~ partial_block_re
          partial_name, partial_text = $1, $2
          File.open(partial_name, "w") { |f| f.write $2 }
          text.sub! partial_block_re, ''
        end
      else
      # See if there are any render :partial statements to expand
        current_file.buffer.lines.each_with_index do |line, i|
          text << line
          if line =~ /render[\s\(].*:partial\s*=>\s*['"](.+?)['"]/
            partial_name = $1
            modules = current_file.modules + [current_file.controller_name]
    
            # Check for absolute path to partial file
            if partial_name.include?('/')
              pieces = partial_name.split('/')
              partial_name = pieces.pop
              modules = pieces
            end
    
            partial = File.join(current_file.rails_root, 'app', 'views', modules, "_#{partial_name}.html.erb")
    
            text << "<!-- [[ Partial '#{partial}' Begin ]] -->\n"
            text << IO.read(partial).gsub("\r\n", "\n")
            text << "<!-- [[ Partial '#{partial}' End ]] -->\n"
          end
        end
      end
      print text
      context.exit_replace_document
    end
    nil
  end    
end
