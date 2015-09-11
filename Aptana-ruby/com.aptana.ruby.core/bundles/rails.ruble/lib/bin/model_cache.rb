require "yaml"

cache_file = ARGV.shift
project_directory = ARGV.shift

begin
  cache = {}
  File.delete(cache_file) if File.exists?(cache_file)
  
  begin
    Dir.chdir project_directory
    require "#{project_directory}/config/environment"
    
    Dir.glob(File.join(Rails.root, "app/models/*.rb")) do |file|
      klass = File.basename(file, '.*').camelize.constantize rescue nil
  
      if klass and klass.class == Class and klass.ancestors.include?(ActiveRecord::Base)
        cache[klass.name.underscore] = { 
          :associations => klass.reflections.stringify_keys.keys,
          :columns      => klass.column_names
        } rescue nil
      end
    end
  
    File.open(cache_file, 'w') { |out| YAML.dump(cache, out) }
  rescue Exception => e
   puts "Fix it: #{e.message}"
  end
rescue Exception => e
  puts "Fix it: #{e.message}"
end