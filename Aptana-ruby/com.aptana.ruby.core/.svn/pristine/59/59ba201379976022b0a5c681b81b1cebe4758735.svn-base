
class Generator
  @@list = []
  attr_accessor :name, :question, :default_answer

  def initialize(name, question, default_answer = "")
    @@list << self
    @name, @question, @default_answer = name, question, default_answer
  end

  def self.[](name, question, default_answer = "")
    g = new(name, question, default_answer)
  end

  def self.setup
    @@list = setup_generators
  end

  # Collect the names from each generator
  def self.names
    @@list.map { |g| g.name.capitalize }
  end

  def self.generators
    @@list
  end

  def self.setup_generators
    known_generator_names = known_generators.map { |gen| gen.name }
    new_generator_names = find_generator_names - known_generator_names
    known_generators + new_generator_names.map do |name|
      Generator[name, t(:args_for_0_generator, :name => name), ""]
    end
  end

  # Runs the script/generate command and extracts generator names from output
  def self.find_generator_names
    list = nil

    FileUtils.chdir(RailsPath.new.rails_root) do
      if File.exists?("script/generate")
        output = ruby 'script/generate'
        output = output.grep(/^  [A-Z]/).to_s.gsub!("  ", "")
        output = "" if output.nil?
        list = output.split(/[,\s]+/).reject {|f| f =~ /:/}
      else
        output = ruby 'rails generate'
        output = output.grep(/^  [A-Za-z]/).to_s.gsub!("  ", "")
        output = "" if output.nil?
        list = output.split(/\n/)
        list.each do |name|
          name.strip!
        end
      end
    end
    list
  end


  def self.known_generators
    [
      Generator["scaffold",   t(:name_scaffold_prompt),   "User"],
      Generator["controller", t(:name_controller_prompt), "admin/user_accounts"],
      Generator["model",      t(:name_model_prompt),      "User"],
      Generator["mailer",     t(:name_mailer_prompt),     "Notify"],
      Generator["migration",  t(:name_migration_prompt),  "CreateUserTable"],
      Generator["plugin",     t(:name_plugin_prompt),     "ActsAsPlugin"]
    ]
  end
  
  # Look for (created) files and return an array of them
  def self.files_from_generator_output(output, type = 'create')
    output.to_a.map { |line| line.scan(/#{type}\s+([^\s]+)$/).flatten.first }.compact.select { |f| File.exist?(f) and !File.directory?(f) }
  end
end

