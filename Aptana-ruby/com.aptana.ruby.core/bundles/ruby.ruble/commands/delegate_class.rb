require 'ruble'

command 'class .. < DelegateClass .. initialize .. end' do |cmd|
  cmd.trigger = 'cla'
  cmd.scope = 'source.ruby'
  cmd.output = :insert_as_snippet
  cmd.input = :document
  cmd.invoke do |context|
    require 'ruby_requires'
    require 'insert'
    
    class_name = ENV['TM_FILENAME'].gsub(/(?:\A|_)([A-Za-z0-9]+)(?:\.rb)?/, '\1')
    class_name = class_name[0, 1].upcase + class_name[1..-1]
    # FIXME Seems to be adding an extra newline before snippet!
    snippet = "class ${1:#{class_name}} < DelegateClass(${2:ParentClass})
  def initialize(${3:args})
    super(${4:del_obj})
    
    $0
  end
  
  
end"
    insert_at_cursor(STDIN.read, snippet) {|code| RubyRequires.add_requires(code, 'delegate') }
  end
end
