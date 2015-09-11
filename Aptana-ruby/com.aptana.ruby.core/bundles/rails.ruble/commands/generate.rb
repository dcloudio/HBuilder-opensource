require 'ruble'

# FIXME: this file is rife with textmate-isms!!!
  
command t(:call_generate_script) do |cmd|
  #cmd.key_binding = 'CONTROL+SHIFT+\\'
  cmd.scope = "source.ruby.rails, source.yaml, project.rails"
  cmd.output = :discard
  cmd.input = :none
  cmd.invoke do |context|
    require 'rails_bundle_tools'
    require "rails/generator"
    
    Generator.setup
    if choice = Ruble.choose(t(:generate_prompt), Generator.names.map { |name| Inflector.humanize name }, :title => t(:generate_title))
      arguments = Ruble::UI.request_string(
        :title => t(:name_generator, :name => Inflector.humanize(Generator.generators[choice].name)), 
        :default => Generator.generators[choice].default_answer,
        :prompt => Generator.generators[choice].question,
        :button1 => t(:generate_button)
      )

      if arguments
        options = ""
        rails_version = %x{rails -v}.chomp.scan(/[0-9][0-9\.]+/).first.to_i
        
        case choice
        when 0
          if rails_version < 2
            options = Ruble::UI.request_string(
             :title => t(:scaffold_controller_name), 
             :prompt => t(:scaffold_controller_prompt),
             :button1 => t(:continue)
            )
            options = "'#{options}'"
          else
            options = Ruble::UI.request_string(
             :title => t(:scaffold_model_attributes), 
             :default => "username:string",
             :prompt => t(:scaffold_model_prompt),
             :button1 => t(:continue)
            )
            options = "#{options}"
          end
        when 1
          options = Ruble::UI.request_string(
            :title => t(:controller_actions_title), 
            :default => "index new create edit update destroy",
            :prompt => t(:controller_actions_prompt),
            :button1 => t(:create)
          )
        end

        # add the --svn option, if needed
        proj_dir = Ruble.project_directory
        if proj_dir and File.exist?(File.join(proj_dir, ".svn"))
          options << " --svn"
        end
        if proj_dir and File.exist?(File.join(proj_dir, ".git"))
          options << " --git"
        end

        require 'fileutils'
        FileUtils.cd proj_dir
        
        if File.exists?("script/rails")
          generate_cmd = "script/rails generate"
        else
          generate_cmd = "script/generate"
        end
        
        command = "#{generate_cmd} #{Generator.generators[choice].name} #{arguments} #{options}"
        Ruble::Logger.trace "Command: #{command}"

        output = ruby(command)
        Ruble::Logger.trace "Output: #{output}"
        Ruble.rescan_project
        files = Generator.files_from_generator_output(output)
        files.each { |f| Ruble.open(File.join(proj_dir, f)) }

        Ruble::UI.simple_notification(
          :title => t(:generator_complete),
          :summary => t(:done_generating_0, :name => Generator.generators[choice].name),
          :log => output
        )
      end
    end
  end
end
