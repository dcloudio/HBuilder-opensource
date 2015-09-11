require 'ruble'

with_defaults :scope => "source.ruby" do |bundle|

  snippet '#!/usr/bin/env ruby -wKU' do |s|
    s.trigger = 'rb'
    s.expansion = '#!/usr/bin/env ruby -wKU
'
  end
  
  snippet ':yields:' do |s|
    s.trigger = 'y'
    s.expansion = ' :yields: ${1:arguments}'
  end
  
  snippet 'if ... else ... end' do |s|
    s.trigger = 'ife'
    s.expansion = 
'if ${1:condition}
	$2
else
	$3
end'
  end
  
  snippet 'if ... end' do |s|
    s.trigger = 'if'
    s.expansion = 'if ${1:condition}
  $0
end'
  end
  
  snippet 'case ... end' do |s|
    s.trigger = 'case'
    s.expansion = 
'case ${1:object}
when ${2:condition}
	$0
end'
  end
  
  snippet '__END__' do |s|
    s.trigger = 'end'
    s.expansion = '__END__
'
  end
  
  snippet t(:add_hash_marker) do |s|
    s.trigger = '#'
    s.expansion = '# => '
  end
  
  snippet 'alias_method ..' do |s|
    s.trigger = 'am'
    s.expansion = 'alias_method :${1:new_name}, :${2:old_name}'
  end
  
  snippet 'all? { |e| .. }' do |s|
    s.trigger = 'all'
    s.expansion = 'all? { |${1:e}| $0 }'
  end
  
  snippet 'any? { |e| .. }' do |s|
    s.trigger = 'any'
    s.expansion = 'any? { |${1:e}| $0 }'
  end
  
  snippet 'application { .. }' do |s|
    s.trigger = 'app'
    s.expansion = 'if __FILE__ == \$PROGRAM_NAME
  $0
end'
  end

  snippet 'Array.new(10) { |i| .. }' do |s|
    s.trigger = 'Array'
    s.expansion = 'Array.new(${1:10}) { |${2:i}| $0 }'
  end
  
  snippet 'assert_nothing_raised(..) { .. }' do |s|
    s.trigger = 'asnr'
    s.expansion = 'assert_nothing_raised(${1:Exception}) { $0 }'
  end
  
  snippet 'assert_nothing_thrown { .. }' do |s|
    s.trigger = 'asnt'
    s.expansion = 'assert_nothing_thrown { $0 }'
  end
  
  snippet 'assert_raise(..) { .. }' do |s|
    s.trigger = 'asr'
    s.expansion = 'assert_raise(${1:Exception}) { $0 }'
  end

  snippet 'assert_throws(..) { .. }' do |s|
    s.trigger = 'ast'
    s.expansion = 'assert_throws(:${1:expected}) { $0 }'
  end
  
  snippet 'attr_accessor ..' do |s|
    s.trigger = 'rw'
    s.expansion = 'attr_accessor :${1:attr_names}'
  end
  
  snippet 'attr_reader ..' do |s|
    s.trigger = 'r'
    s.expansion = 'attr_reader :${1:attr_names}'
  end
  
  snippet 'attr_writer ..' do |s|
    s.trigger = 'w'
    s.expansion = 'attr_writer :${1:attr_names}'
  end
    
  snippet 'class .. < Test::Unit::TestCase .. end' do |s|
    s.trigger = 'tc'
    s.expansion = 'require "test/unit"
      
require "${1:library_file_name}"

class Test${2:ClassName} < Test::Unit::TestCase
  def test_${3:case_name}
    $0
	end
end'
  end
  
  snippet 'class BlankSlate .. initialize .. end' do |s|
    s.trigger = 'cla'
    s.expansion = 'class ${1:BlankSlate}
  instance_methods.each { |meth| undef_method(meth) unless meth =~ /\A__/ }
  	
  def initialize(${2:args})
    @${3:delegate} = ${4:delegate_object}

    $0
  end

  def method_missing(meth, *args, &block)
    @${3:delegate}.send(meth, *args, &block)
  end
  	  	
end'
  end
  
  snippet 'class << self .. end' do |s|
    s.trigger = 'cla'
    s.expansion = 'class << ${1:self}
  $0
end'
  end
  
  snippet 'class_from_name()' do |s|
    s.trigger = 'clafn'
    s.expansion = 'split("::").inject(Object) { |par, const| par.const_get(const) }'
  end
  
  snippet 'classify { |e| .. }' do |s|
    s.trigger = 'cl'
    s.expansion = 'classify { |${1:e}| $0 }'
  end
  
  snippet 'collect { |e| .. }' do |s|
    s.trigger = 'col'
    s.expansion = 'collect { |${1:e}| $0 }'
  end
  
  snippet 'deep_copy(..)' do |s|
    s.trigger = 'deec'
    s.expansion = 'Marshal.load(Marshal.dump(${1:obj_to_copy}))'
  end
  
  snippet 'def ... end' do |s|
    s.trigger = 'def'
    s.expansion = 'def ${1:method_name}
  $0
end'
  end
  
  snippet 'def method_missing .. end' do |s|
    s.trigger = 'defmm'
    s.expansion = 'def method_missing(meth, *args, &blk)
  $0
end'
  end
  
  snippet 'def self .. end' do |s|
    s.trigger = 'defs'
    s.expansion = 'def self.${1:class_method_name}
  $0
end'
  end
  
  snippet 'def test_ .. end' do |s|
    s.trigger = 'deft'
    s.expansion = 'def test_${1:case_name}
  $0
end'
  end
  
  snippet 'def_delegator ..' do |s|
    s.trigger = 'defd'
    s.expansion = 'def_delegator :${1:@del_obj}, :${2:del_meth}, :${3:new_name}'
  end
  
  snippet 'def_delegators ..' do |s|
    s.trigger = 'defds'
    s.expansion = 'def_delegators :${1:@del_obj}, :${2:del_methods}'
  end
  
  snippet 'delete_if { |e| .. }' do |s|
    s.trigger = 'deli'
    s.expansion = 'delete_if { |${1:e}| $0 }'
  end
  
  snippet 'detect { |e| .. }' do |s|
    s.trigger = 'det'
    s.expansion = 'detect { |${1:e}| $0 }'
  end

  snippet 'Dir.glob("..") { |file| .. }' do |s|
    s.trigger = 'Dir'
    s.expansion = 'Dir.glob("${1:*}") { |${2:file}| $0 }'
  end

  snippet 'Dir[".."]' do |s|
    s.trigger = 'Dir'
    s.expansion = 'Dir["${1:*.rb}"]'
  end
  
  snippet 'directory()' do |s|
    s.trigger = 'dir'
    s.expansion = 'File.dirname(__FILE__)'
  end

  snippet t(:insert_multiline_block) do |s|
    s.trigger = 'do'
    s.expansion = 'do |${1:variable}|
  $0
end'
  end

  snippet 'downto(0) { |n| .. }' do |s|
    s.trigger = 'dow'
    s.expansion = 'downto(${1:0}) { |${2:n}| $0 }'
  end
  
  snippet 'each { |e| .. }' do |s|
    s.trigger = 'ea'
    s.expansion = 'each { |${1:e}| $0 }'
  end
  
  snippet 'each_byte { |byte| .. }' do |s|
    s.trigger = 'eab'
    s.expansion = 'each_byte { |${1:byte}| $0 }'
  end
  
  snippet 'each_index { |i| .. }' do |s|
    s.trigger = 'eai'
    s.expansion = 'each_index { |${1:i}| $0 }'
  end
  
  snippet 'each_key { |key| .. }' do |s|
    s.trigger = 'eak'
    s.expansion = 'each_key { |${1:key}| $0 }'
  end
  
  snippet 'each_line { |line| .. }' do |s|
    s.trigger = 'eal'
    s.expansion = 'each_line$1 { |${2:line}| $0 }'
  end
  
  snippet 'each_pair { |name, val| .. }' do |s|
    s.trigger = 'eap'
    s.expansion = 'each_pair { |${1:name}, ${2:val}| $0 }'
  end
  
  snippet 'each_slice(..) { |group| .. }' do |s|
    s.trigger = 'eas-'
    s.expansion = 'each_slice(${1:2}) { |${2:group}| $0 }'
  end
  
  snippet 'each_value { |val| .. }' do |s|
    s.trigger = 'eav'
    s.expansion = 'each_value { |${1:val}| $0 }'
  end
  
  snippet 'each_with_index { |e, i| .. }' do |s|
    s.trigger = 'eawi'
    s.expansion = 'each_with_index { |${1:e}, ${2:i}| $0 }'
  end
  
  snippet 'elsif ...' do |s|
    s.trigger = 'elsif'
    s.expansion = 'elsif ${1:condition}
  $0'
  end

  snippet 'fetch(name) { |key| .. }' do |s|
    s.trigger = 'fet'
    s.expansion = 'fetch(${1:name}) { |${2:key}| $0 }'
  end
  
  snippet 'File.foreach ("..") { |line| .. }' do |s|
    s.trigger = 'File'
    s.expansion = 'File.foreach("${1:path_to_file}") { |${3:line}| $0 }'
  end

  snippet 'File.open("..") { |file| .. }' do |s|
    s.trigger = 'File'
    s.expansion = 'File.open("${1:path_to_file}", "${2:r/r+/w/w+/a/a+/b}") { |${3:file}| $0 }'
  end
  
  snippet 'File.read("..")' do |s|
    s.trigger = 'File'
    s.expansion = 'File.read("${1:path_to_file}")'
  end

  snippet 'fill(range) { |i| .. }' do |s|
    s.trigger = 'fil'
    s.expansion = 'fill(${1:range}) { |${2:i}| $0 }'
  end
  
  snippet 'find { |e| .. }' do |s|
    s.trigger = 'fin'
    s.expansion = 'find { |${1:e}| $0 }'
  end
  
  snippet 'find_all { |e| .. }' do |s|
    s.trigger = 'fina'
    s.expansion = 'find_all { |${1:e}| $0 }'
  end
  
  snippet 'flatten_once()' do |s|
    s.trigger = 'flao'
    s.expansion = 'inject(Array.new) { |${1:arr}, ${2:a}| ${1:arr}.push(*${2:a}) }'
  end
  
  snippet 'grep(/pattern/) { |match| .. }' do |s|
    s.trigger = 'gre'
    s.expansion = 'grep(/${1:pattern}/) { |${2:match}| $0 }'
  end

  snippet 'gsub(/../) { |match| .. }' do |s|
    s.trigger = 'gsu'
    s.expansion = 'gsub(/${1:pattern}/) { |${2:match}| $0 }'
  end
  
  snippet 'Hash Pair - :key => "value"' do |s|
    s.trigger = ':'
    s.expansion = ':${1:key} => ${2:"value"}${3:, }'
  end
  
  snippet 'Hash.new { |hash, key| hash[key] = .. }' do |s|
    s.trigger = 'Hash'
    s.expansion = 'Hash.new { |${1:hash}, ${2:key}| ${1:hash}[${2:key}] = $0 }'
  end
  
  snippet 'include Comparable ..' do |s|
    s.trigger = 'Comp'
    s.expansion = 'include Comparable

def <=>(other)
  $0
end'
  end
  
  snippet 'include Enumerable ..' do |s|
    s.trigger = 'Enum'
    s.expansion = 'include Enumerable

def each(&block)
  $0
end'
  end
  
  snippet 'inject(init) { |mem, var| .. }' do |s|
    s.trigger = 'inj'
    s.expansion = 'inject(${1:init}) { |${2:mem}, ${3:var}| $0 }'
  end

  snippet 'lambda { |args| .. }' do |s|
    s.trigger = 'lam'
    s.expansion = 'lambda { |${1:args}| $0 }'
  end
  
  snippet 'loop { .. }' do |s|
    s.trigger = 'loo'
    s.expansion = 'loop { $0 }'
  end
  
  snippet 'map { |e| .. }' do |s|
    s.trigger = 'map'
    s.expansion = 'map { |${1:e}| $0 }'
  end
  
  snippet 'Marshal.dump(.., file)' do |s|
    s.trigger = 'Md'
    s.expansion = 'File.open("${1:path_to_file}.dump", "wb") { |${2:file}| Marshal.dump(${3:obj}, ${2:file}) }'
  end
  
  snippet 'Marshal.load(obj)' do |s|
    s.trigger = 'Ml'
    s.expansion = 'File.open("${1:path_to_file}.dump", "rb") { |${2:file}| Marshal.load(${2:file}) }'
  end
  
  snippet 'max { |a, b| .. }' do |s|
    s.trigger = 'max'
    s.expansion = 'max { |a, b| $0 }'
  end
  
  snippet 'min { |a, b| .. }' do |s|
    s.trigger = 'min'
    s.expansion = 'min { |a, b| $0 }'
  end

  snippet t(:insert_block) do |s|
    s.trigger = '{'
    s.expansion = '{ |${1:variable}| ${0} }'
  end

  snippet 'open("path_or_url", "w") { |io| .. }' do |s|
    s.trigger = 'ope'
    s.expansion = 'open("${1:path_or_url_or_pipe}", "${2:r/r+/w/w+/a/a+/b}") { |${3:io}| $0 }'
  end

  snippet 'option_parse { .. }' do |s|
    s.trigger = 'optp'
    s.expansion = 'require "optparse"

options = {${1::default => "args"}}

ARGV.options do |opts|
  opts.banner = "Usage:  #{File.basename(\$PROGRAM_NAME)} [OPTIONS] ${2:OTHER_ARGS}"
	
  opts.separator ""
  opts.separator "Specific Options:"
	
  $0
	
  opts.separator "Common Options:"
	
  opts.on( "-h", "--help",
  	 "Show this message." ) do
    puts opts
    exit
  end
	
  begin
    opts.parse!
  rescue
    puts opts
    exit
  end
end
'
  end
  
  snippet 'partition { |e| .. }' do |s|
    s.trigger = 'par'
    s.expansion = 'partition { |${1:e}| $0 }'
  end
  
  snippet 'path_from_here( .. )' do |s|
    s.trigger = 'patfh'
    s.expansion = 'File.join(File.dirname(__FILE__), *%w[${1:rel path here}])'
  end
  
  snippet 'randomize()' do |s|
    s.trigger = 'ran'
    s.expansion = 'sort_by { rand }'
  end
  
  snippet 'reject { |e| .. }' do |s|
    s.trigger = 'rej'
    s.expansion = 'reject { |${1:e}| $0 }'
  end
  
  snippet 'require ".."' do |s|
    s.trigger = 'req'
    s.expansion = 'require "$0"'
  end
  
  snippet 'require "tc_.." ..' do |s|
    s.trigger = 'ts'
    s.expansion = 'require "test/unit"

require "tc_${1:test_case_file}"
require "tc_${2:test_case_file}"
'
  end
  
  snippet 'results.report(..) { .. }' do |s|
    s.trigger = 'rep'
    s.expansion = 'results.report("${1:name}:") { TESTS.times { $0 } }'
  end
  
  snippet 'reverse_each { |e| .. }' do |s|
    s.trigger = 'reve'
    s.expansion = 'reverse_each { |${1:e}| $0 }'
  end
  
  snippet 'scan(/../) { |match| .. }' do |s|
    s.trigger = 'sca'
    s.expansion = 'scan(/${1:pattern}/) { |${2:match}| $0 }'
  end
  
  snippet 'select { |e| .. }' do |s|
    s.trigger = 'sel'
    s.expansion = 'select { |${1:e}| $0 }'
  end
  
  snippet 'singleton_class()' do |s|
    s.trigger = 'sinc'
    s.expansion = 'class << self; self end'
  end
  
  snippet 'sort { |a, b| .. }' do |s|
    s.trigger = 'sor'
    s.expansion = 'sort { |a, b| $0 }'
  end
  
  snippet 'sort_by { |e| .. }' do |s|
    s.trigger = 'sorb'
    s.expansion = 'sort_by { |${1:e}| $0 }'
  end

  snippet 'step(2) { |e| .. }' do |s|
    s.trigger = 'ste'
    s.expansion = 'step(${1:2}) { |${2:n}| $0 }'
  end

  snippet 'sub(/../) { |match| .. }' do |s|
    s.trigger = 'sub'
    s.expansion = 'sub(/${1:pattern}/) { |${2:match}| $0 }'
  end

  snippet 'task :task_name => [:dependent, :tasks] do .. end' do |s|
    s.trigger = 'tas'
    s.expansion = 'desc "${1:Task description}"
task :${2:task_name} => ${3:[:dependent, :tasks]} do
  $0
end'
  end

  snippet 'times { |n| .. }' do |s|
    s.trigger = 'tim'
    s.expansion = 'times { |${1:n}| $0 }'
  end
  
  snippet 'transaction( .. ) { .. }' do |s|
    s.trigger = 'tra'
    s.expansion = 'transaction(${1:true}) { $0 }'
  end
  
  snippet 'unix_filter { .. }' do |s|
    s.trigger = 'unif'
    s.expansion = 'ARGF.each_line$1 do |${2:line}|
  $0
end'
  end
  
  snippet 'unless ... end' do |s|
    s.trigger = 'unless'
    s.expansion = 'unless ${1:condition}
  $0
end'
  end
  
  snippet 'until ... end' do |s|
    s.trigger = 'until'
    s.expansion = 'until ${1:condition}
  $0
end'
  end

  snippet 'option(..)' do |s|
    s.trigger = 'opt'
    s.expansion = 'opts.on( "-${1:o}", "--${2:long-option-name}", ${3:String},
     "${4:Option description.}" ) do |${6:opt}|
  $0
end'
  end

  snippet 'upto(1.0/0.0) { |n| .. }' do |s|
    s.trigger = 'upt'
    s.expansion = 'upto(${1:1.0/0.0}) { |${2:n}| $0 }'
  end
  
  snippet 'usage_if()' do |s|
    s.trigger = 'usai'
    s.expansion = 'if ARGV.$1
  abort "Usage:  #{\$PROGRAM_NAME} ${2:ARGS_GO_HERE}"
end'
  end
  
  snippet 'usage_unless()' do |s|
    s.trigger = 'usau'
    s.expansion = 'unless ARGV.$1
  abort "Usage:  #{\$PROGRAM_NAME} ${2:ARGS_GO_HERE}"
end'
  end
  
  snippet 'when ...' do |s|
    s.trigger = 'when'
    s.expansion = 'when ${1:condition}
  $0'
  end
  
  snippet 'while ... end' do |s|
    s.trigger = 'while'
    s.expansion = 'while ${1:condition}
  $0
end'
  end
  
  snippet 'xpath(..) { .. }' do |s|
    s.trigger = 'xpa'
    s.expansion = 'elements.each("${1:XPath}") do |${2:node}|
  $0
end'
  end
  
  snippet 'zip(enums) { |row| .. }' do |s|
    s.trigger = 'zip'
    s.expansion = 'zip(${1:enums}) { |${2:row}| $0 }'
  end

end

# =====================================================================================================================================
# These are snippets which got converted because they made reference to ENV vars and used regular expression search/replace on them
# to come up with default values to use.
with_defaults :output => :insert_as_snippet, :input => :none, :trigger => 'cla', :scope => 'source.ruby' do |bundle|
  
  command 'class .. < ParentClass .. initialize .. end' do |s|
    s.invoke do |context|
      class_name = ENV['TM_FILENAME'].gsub(/(?:\A|_)([A-Za-z0-9]+)(?:\.rb)?/, '\1')
      class_name = class_name[0, 1].upcase + class_name[1..-1]
"class ${1:#{class_name}} < ${2:ParentClass}
  def initialize(${3:args})
    $0
  end
    
end"
    end
  end
  
  command 'ClassName = Struct .. do .. end' do |s|
    s.invoke do |context|
      class_name = ENV['TM_FILENAME'].gsub(/(?:\A|_)([A-Za-z0-9]+)(?:\.rb)?/, '\1')
      class_name = class_name[0, 1].upcase + class_name[1..-1]
"${1:#{class_name}} = Struct.new(:${2:attr_names}) do
  def ${3:method_name}
    $0
  end
  
end"
    end
  end
  
  command 'class .. end' do |s|
    s.invoke do |context|
      class_name = ENV['TM_FILENAME'].gsub(/(?:\A|_)([A-Za-z0-9]+)(?:\.rb)?/, '\1')
      class_name = class_name[0, 1].upcase + class_name[1..-1]
"class ${1:#{class_name}}
  $0
end"
    end
  end
  
  command 'class .. initialize .. end' do |s|
    s.invoke do |context|
      class_name = ENV['TM_FILENAME'].gsub(/(?:\A|_)([A-Za-z0-9]+)(?:\.rb)?/, '\1')
      class_name = class_name[0, 1].upcase + class_name[1..-1]
"class ${1:#{class_name}}
  def initialize(${2:args})
    $0
  end
end"
    end
  end
  
end

with_defaults :output => :insert_as_snippet, :input => :none, :trigger => 'mod', :scope => 'source.ruby' do |bundle|

  command 'module .. ClassMethods .. end' do |s|
    s.invoke do |context|
      class_name = ENV['TM_FILENAME'].gsub(/(?:\A|_)([A-Za-z0-9]+)(?:\.rb)?/, '\1')
      class_name = class_name[0, 1].upcase + class_name[1..-1]
"module ${1:#{class_name}}
  module ClassMethods
    $0
  end
  
  module InstanceMethods
    
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end"
    end
  end

  command 'module .. end' do |s|
    s.invoke do |context|
      class_name = ENV['TM_FILENAME'].gsub(/(?:\A|_)([A-Za-z0-9]+)(?:\.rb)?/, '\1')
      class_name = class_name[0, 1].upcase + class_name[1..-1]
"module ${1:#{class_name}}
  $0
end"
    end
  end

  command 'module .. module_function .. end' do |s|
    s.invoke do |context|
      class_name = ENV['TM_FILENAME'].gsub(/(?:\A|_)([A-Za-z0-9]+)(?:\.rb)?/, '\1')
      class_name = class_name[0, 1].upcase + class_name[1..-1]
"module ${1:#{class_name}}
  module_function
  
  $0
end"
    end
  end

  command 'namespace :.. do .. end' do |s|
    s.trigger = 'nam'
    s.invoke do |context|
      namespace = ENV['TM_FILENAME'].gsub(/\.\w+/, '')
"namespace :${1:#{namespace}} do
  $0
end"
    end
  end
end

# =====================================================================================================================================
# This was converted because it uses selection and manipulates it with regular expressions
with_defaults :output => :insert_as_snippet, :input => :selection, :scope => 'source.ruby', :trigger => 'begin' do |bundle| 

  command 'begin ... rescue ... end' do |s|
    s.invoke do |context|
      selected = STDIN.read      
"begin
  ${3:#{selected.gsub(/(\A.*)|(.+)|\n\z/, '$0')}}
rescue ${1:Exception} => ${2:e}
  $0
end
"
    end
  end
end

# =====================================================================================================================================
# These are snippets which got converted because they executed snippet_paren.rb to optionally place wrapping parens based on an ENV var.
def paren(side = :start)
  minimize = ENV["TM_MINIMIZE_PARENS"].to_s =~ /\byes\b/i
  case side
  when :start
    minimize ? " " : "("
  when :end
    minimize ? "" : ")"
  end
end

with_defaults :output => :insert_as_snippet, :input => :none, :scope => 'source.ruby' do |bundle| 

  command 'assert(..)' do |s|
    s.trigger = 'as'
    s.invoke {|context| "assert#{paren}${1:test}, \"${2:Failure message.}\"#{paren(:end)}" }
  end

  command 'assert_equal(..)' do |s|
    s.trigger = 'ase'
    s.invoke {|context| "assert_equal#{paren}${1:expected}, ${2:actual}#{paren(:end)}" }
  end

  command 'assert_in_delta(..)' do |s|
    s.trigger = 'asid'
    s.invoke {|context| "assert_in_delta#{paren}${1:expected_float}, ${2:actual_float}, ${3:2 ** -20}#{paren(:end)}" }
  end

  command 'assert_instance_of(..)' do |s|
    s.trigger = 'asio'
    s.invoke {|context| "assert_instance_of#{paren}${1:ExpectedClass}, ${2:actual_instance}#{paren(:end)}" }
  end

  command 'assert_kind_of(..)' do |s|
    s.trigger = 'asko'
    s.invoke {|context| "assert_kind_of#{paren}${1:ExpectedKind}, ${2:actual_instance}#{paren(:end)}" }
  end

  command 'assert_match(..)' do |s|
    s.trigger = 'asm'
    s.invoke {|context| "assert_match#{paren}/${1:expected_pattern}/, ${2:actual_string}#{paren(:end)}" }
  end

  command 'assert_nil(..)' do |s|
    s.trigger = 'asn'
    s.invoke {|context| "assert_nil#{paren}${1:instance}#{paren(:end)}" }
  end

  command 'assert_no_match(..)' do |s|
    s.trigger = 'asnm'
    s.invoke {|context| "assert_no_match#{paren}/${1:unexpected_pattern}/, ${2:actual_string}#{paren(:end)}" }
  end

  command 'assert_not_equal(..)' do |s|
    s.trigger = 'asne'
    s.invoke {|context| "assert_not_equal#{paren}${1:unexpected}, ${2:actual}#{paren(:end)}" }
  end

  command 'assert_not_nil(..)' do |s|
    s.trigger = 'asnn'
    s.invoke {|context| "assert_not_nil#{paren}${1:instance}#{paren(:end)}" }
  end

  command 'assert_not_same(..)' do |s|
    s.trigger = 'asns'
    s.invoke {|context| "assert_not_same#{paren}${1:unexpected}, ${2:actual}#{paren(:end)}" }
  end

  command 'assert_respond_to(..)' do |s|
    s.trigger = 'asrt'
    s.invoke {|context| "assert_respond_to#{paren}${1:object}, :${2:method}#{paren(:end)}" }
  end

  command 'assert_same(..)' do |s|
    s.trigger = 'ass'
    s.invoke {|context| "assert_same#{paren}${1:expected}, ${2:actual}#{paren(:end)}" }
  end

  command 'assert_send(..)' do |s|
    s.trigger = 'ass'
    s.invoke {|context| "assert_send#{paren}[${1:object}, :${2:message}, ${3:args}]#{paren(:end)}" }
  end

  command 'assert_operator(..)' do |s|
    s.trigger = 'aso'
    s.invoke {|context| "assert_operator#{paren}${1:left}, :${2:operator}, ${3:right}#{paren(:end)}" }
  end

  command 'flunk(..)' do |s|
    s.trigger = 'fl'
    s.invoke {|context| "flunk#{paren}\"${1:Failure message.}\"#{paren(:end)}" }
  end
end

# =====================================================================================================================================
# This snippet was converted because it had inline execution of shell code referring to an ENV var
with_defaults :output => :insert_as_snippet, :input => :none, :scope => 'source.ruby' do |bundle| 
  command 'New Block' do |s|
    s.trigger = '=b'
    s.invoke do |context|
      nl = ENV['TM_LINE_INDEX'].to_i != 0 ? "\n" : ''
"#{nl}=begin rdoc
  $0
=end"
    end
  end
end