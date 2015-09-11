# Copyright:
#   (c) 2006 syncPEOPLE, LLC.
#   Visit us at http://syncpeople.com/
# Author: Duane Johnson (duane.johnson@gmail.com)
# Description:
#   Helper module for accesing ruble facilities such as environment variables.

require 'uri'
require 'ruble/ui'
require 'ruble/editor'
require 'ruble/project'

module Ruble
  class <<self

    # Open a file in ruble.  Uses 0-based line and column indices.
    def open(filename, line_number = nil, column_number = nil)
      filename = filename.filepath if filename.is_a? RailsPath
      options = {}
      options[:file] = URI.escape(filename)
      options[:line] = line_number + 1 if line_number
      options[:column] = column_number + 1 if column_number
      Ruble::Editor.go_to options
    end

    # Always return something, or nil, for selected_text
    def selected_text
      env(:selected_text)
    end

    # Make line_number 0-base index
    def line_number
      env(:line_number).to_i - 1
    end

    # Make column_number 0-base as well
    def column_number
      env(:column_number).to_i - 1
    end

    def project_directory
      env(:project_directory)
    end
    
    # Uses the TM_FILEPATh variable value. If not defined (no editor open),
    # then grab first selected file in App Explorer
    def filepath
      value = env(:filepath)
      return value if value
      value = env(:selected_files)
      return nil unless value
      # Grab the first value out of the string
      value = value[1..-2] # Strip leading and trailing single quotes
      index = value.index("' ")
      value = value[0..(index - 1)] if index
      value
    end

    def env(var)
      ENV['TM_' + var.to_s.upcase]
    end
    
    # Forward to the TM_* environment variables if method is missing.  Some useful variables include:
    #   selected_text, current_line, column_number, line_number, support_path
    def method_missing(method, *args)
      if value = env(method)
        return value
      else
        super(method, *args)
      end
    end
    
    def choose(text, choices = ["none"], options = {})
      options = {:title => "Choose", :prompt => text, :items => choices, :button1 => 'Ok', :button2 => 'Cancel'}.update(options)
      choice = Ruble::UI.request_item(options)
      return nil if choice.nil?
      choices.each_with_index {|item, index| return index if item == choice}
      nil
    end
    
    def rescan_project
      Ruble::Project.current.to_dir.refresh
    end
  end
end
