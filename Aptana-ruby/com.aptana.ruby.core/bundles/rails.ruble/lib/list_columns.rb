require "yaml"
require "rails_bundle_tools"
require "current_word"

CACHE_DIR  = File.expand_path("tmp/radrails/", Ruble.project_directory)
CACHE_FILE = File.join(CACHE_DIR, "cache.yml")

RELOAD_MESSAGE = "Reload database schema..."
LINE = "---"

def load_and_cache_all_models
  output = IO.popen("ruby '#{ENV['TM_BUNDLE_SUPPORT']}/bin/model_cache.rb' '#{CACHE_FILE}' '#{Ruble.project_directory}'") {|io| io.read }
  Ruble::Logger.log_error(output) unless output.nil? || output.empty?
  cache = YAML.load(File.read(CACHE_FILE))
end

def cache
  return @cache if @cache
  Dir.mkdir(CACHE_DIR) unless File.exists?(CACHE_DIR)
  @cache = File.exist?(CACHE_FILE) ? YAML.load(File.read(CACHE_FILE)) : load_and_cache_all_models
end

def clone_cache(klass, new_word)
  cached_model = cache[klass]
  cache[new_word] = cached_model
  
  File.open(CACHE_FILE, 'w') { |out| YAML.dump(cache, out ) }
end

# Returns the last word before the cursor
# 
def word
  return @word if @word  
  current_word = Word.current_word('a-zA-Z0-9.', :left) # FIXME Need to implement!
  # current_word = ENV['TM_CURRENT_WORD']
  @separator = current_word.end_with?('.') ? '' : '.'
  @word      = current_word.split('.').last
end

def display_menu(klass)
  columns      = cache[klass][:columns]
  associations = cache[klass][:associations]

  options = associations + [LINE] + columns + [LINE, RELOAD_MESSAGE]
  selected = Ruble::UI.menu(options)
  return if selected.nil?
  
  if options[selected] == RELOAD_MESSAGE
    load_and_cache_all_models
    show_options
  else
    $stdout << "#{@separator}#{options[selected]}"
  end
end

def rails_present?
  regex = /^Rails (\d\.?){3}(\w+)?$/
  rails_version = "rails -v 2> /dev/null"
  return `#{rails_version}` =~ regex #|| `bundle exec #{rails_version}` =~ regex
end

# def show_options
#   begin
#     return Ruble::UI.tool_tip("Place cursor on class name (or variation) to show its schema") if word.nil? || word.empty?
#     
#     # Check if Rails is installed.
#     unless rails_present?
#       message = "You don't have Rails installed in this gemset."
#       
#       if File.exists?("#{Ruble.project_directory}/.rvmrc") && 
#         if rvm = File.open("#{Ruble.project_directory}/.rvmrc").read
#           message += " (#{rvm.sub('rvm use', '').strip})"
#         end
#       end
#       
#       return Ruble::UI.tool_tip(message)
#     end
#     
#     klass = Inflector.singularize(Inflector.underscore(word))
# 
#     if cache[klass]
#       display_menu(klass)
#     elsif cache[klass_without_undescore = klass.split('_').last]
#       display_menu(klass_without_undescore)
#     else
#       options = [
#         @error || "'#{Inflector.camelize(klass)}' is not an Active Record derived class or was not recognised as a class.", 
#         LINE,
#         cache.keys.map { |model_name| "Use #{Inflector.camelize(model_name)}..." },
#         LINE,
#         RELOAD_MESSAGE
#       ].flatten
#       selected = Ruble::UI.menu(options)
#       
#       return if selected.nil?
# 
#       case options[selected]
#       when options.first
#         if @error && @error =~ /^#{Ruble.project_directory}(.+?)[:]?(\d+)/
#           Ruble.open(File.join(Ruble.project_directory, \$1), \$2.to_i)
#         else
#           klass_file = File.join(Ruble.project_directory, "/app/models/#{klass}.rb")
#           Ruble.open(klass_file) if File.exist?(klass_file)
#         end
#       when RELOAD_MESSAGE
#         load_and_cache_all_models
#         show_options
#       else
#         klass = Inflector.singularize(Inflector.underscore(options[selected].split[1].delete('...')))
#         clone_cache(klass, word)
#         display_menu(word)
#       end
#     end
# 
#   rescue Exception => e
#     Ruble::UI.tool_tip(e.message)
#   end
# end
