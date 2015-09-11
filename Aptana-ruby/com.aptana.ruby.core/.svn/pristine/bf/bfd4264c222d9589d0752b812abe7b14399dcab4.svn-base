require 'ruble'

command t(:preview) do |cmd|
  #cmd.key_binding = "M1+M2+P"
  cmd.scope = "source.ruby.rails, text.html.ruby, text.haml"
  cmd.output = :discard
  cmd.input = :none
  cmd.invoke do |context|
    default_id = 1 # Default resource id to use
    url = context.project.root_url
    if ENV['TM_FILEPATH']
      project_relative_path = ENV['TM_FILEPATH'].sub(/^#{Regexp.escape(ENV['TM_PROJECT_DIRECTORY'])}\//, '')
      # Grab mapper like "rake routes" does and then reverse engineer the controller and action into an URL!
      require 'rails/rails_path'
      path = RailsPath.new(project_relative_path)
      # FIXME If path is not controller/view/model/helper/unit test/etc type, just assume preview root!
      # Actually introspect routes from the rails app!
      Dir.chdir(ENV['TM_PROJECT_DIRECTORY'])
      cmd_line = "ruby \"#{ENV['TM_BUNDLE_SUPPORT']}/bin/rails3_routes.rb\" \"#{ENV['TM_PROJECT_DIRECTORY']}\" #{path.controller_name} #{path.action_name || 'index'}"
      result = IO.popen(cmd_line) {|io| io.read }
      if result.length == 0 # Something went hinky, couldn't introspect routes
        # The "dumb" way...
        url += path.controller_name
        case (path.action_name || 'index').downcase.to_sym
        when :show, :update, :destroy
          url += "/" + default_id
        when :edit
          url += "/#{default_id}/edit"
        when :index, :create, :list
          url # No changes, just hit controller plural name
        else # :new, 
          url += "/#{path.action_name}"
        end       
      else
        result = result.strip.gsub(/\(.+\)/, '').gsub(/:id/, default_id.to_s)
        url += result 
      end
    end
    url = url.gsub(/\/\//, '/') # Replace // with /
    context.browser.open(url, :browser => :default)   
  end
end
