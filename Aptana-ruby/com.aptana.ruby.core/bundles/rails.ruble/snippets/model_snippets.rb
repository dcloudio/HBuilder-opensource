require 'ruble'

with_defaults :scope => "source.ruby.rails" do |bundle|

  snippet "find(:all)" do |snippet|
    snippet.trigger = "fina"
    # FIXME We can't handle nested snippets
    # snippet.expansion = "find(:all${1:, :conditions => ['${2:${3:field} = ?}', ${5:true}]})"
    snippet.expansion = "find(:all, :conditions => ['${3:field} = ?', ${5:true}])"
  end

  snippet "find(:first)" do |snippet|
    snippet.trigger = "finf"
    # FIXME We can't handle nested snippets
    # snippet.expansion = "find(:first${1:, :conditions => ['${2:${3:field} = ?}', ${5:true}]})"
    snippet.expansion = "find(:first, :conditions => ['${3:field} = ?', ${5:true}])"
  end

  snippet "find(:last)" do |snippet|
    snippet.trigger = "finl"
    # FIXME We can't handle nested snippets
    # snippet.expansion = "find(:last${1:, :conditions => ['${2:${3:field} = ?}', ${5:true}]})"
    snippet.expansion = "find(:last, :conditions => ['${3:field} = ?', ${5:true}])"
  end

  snippet "find(id)" do |snippet|
    snippet.trigger = "fini"
    snippet.expansion = "find(${1:id})"
  end

  snippet "find_each" do |snippet|
    snippet.trigger = "fine"
    # FIXME We can't handle nested snippets or env vars or transformations! Convert to command
    # snippet.expansion = "find_each(${1::conditions => {:${2:field} => ${3:true}\}}) do |${4:${TM_CURRENT_WORD/(\w+)\./\L$1/g}}|\n\t\t$0\n\tend"
    snippet.expansion = "find_each(:conditions => {:${2:field} => ${3:true}}) do |${TM_CURRENT_WORD}|\n\  $0\nend"
  end

  snippet "find_in_batches" do |snippet|
    snippet.trigger = "finb"
    # FIXME We can't handle nested snippets or env vars or transformations! Convert to command
    # snippet.expansion = "find_in_batches(${1::conditions => {:${2:field} => ${3:true}\}}) do |${4:${TM_CURRENT_WORD/(\w+)\./\L$1/g}}s|\n\t\t$4s.each do |$4|\n\t\t\t$0\n\t\tend\n\tend"
    snippet.expansion = "find_in_batches(:conditions => {:${2:field} => ${3:true}}) do |${TM_CURRENT_WORD}s|\n  ${TM_CURRENT_WORD}s.each do |${TM_CURRENT_WORD}|\n    $0\n  end\nend"
  end

  snippet "belongs_to" do |snippet|
    snippet.trigger = "bt"
    # FIXME We can't handle transformations!
    # snippet.expansion = "belongs_to :${1:object}${2:, :class_name => \"${3:${1/[[:alpha:]]+|(_)/(?1::\u$0)/g}}\", :foreign_key => \"${4:${1}_id}\"}"
    snippet.expansion = 'belongs_to :${1:object}, :class_name => "${1}", :foreign_key => "${1}_id"'
  end

  snippet "has_and_belongs_to_many" do |snippet|
    snippet.trigger = "habtm"
    # FIXME We can't handle nested snippets
    # snippet.expansion = "has_and_belongs_to_many :${1:object}${2:, :join_table => \"${3:table_name}\", :foreign_key => \"${4:${1}_id}\"}"
    snippet.expansion = 'has_and_belongs_to_many :${1:object}, :join_table => "${3:table_name}", :foreign_key => "${1}_id"'
  end

  snippet "has_many" do |snippet|
    snippet.trigger = "hm"
    # FIXME We can't handle nested snippets
    # snippet.expansion = "has_many :${1:object}s${2:, :class_name => \"${1}\", :foreign_key => \"${4:reference}_id\"}"
    snippet.expansion = 'has_many :${1:object}s, :class_name => "${1}", :foreign_key => "${4:reference}_id"'
  end

  snippet "has_many (through)" do |snippet|
    snippet.trigger = "hmt"
    # FIXME We can't handle nested snippets
    # snippet.expansion = "has_many :${1:objects}, :through => :${2:join_association}${3:, :source => :${4:${2}_table_foreign_key_to_${1}_table}}"
    snippet.expansion = 'has_many :${1:objects}, :through => :${2:join_association}, :source => :${2}_table_foreign_key_to_${1}_table'
  end

  snippet "has_many :dependent => :destroy" do |snippet|
    snippet.trigger = "hmd"
    # FIXME We can't handle nested snippets
    # snippet.expansion = "has_many :${1:object}s${2:, :class_name => \"${1}\", :foreign_key => \"${4:reference}_id\"}, :dependent => :destroy$0"
    snippet.expansion = 'has_many :${1:object}s, :class_name => "${1}", :foreign_key => "${4:reference}_id", :dependent => :destroy$0'
  end

  snippet "has_one" do |snippet|
    snippet.trigger = "ho"
    # FIXME We can't handle nested snippets or env vars or transformations!
    # snippet.expansion = "has_one :${1:object}${2:, :class_name => \"${3:${1/[[:alpha:]]+|(_)/(?1::\u$0)/g}}\", :foreign_key => \"${4:${1}_id}\"}"
    snippet.expansion = 'has_one :${1:object}, :class_name => "${1}", :foreign_key => "${1}_id"'
  end

  snippet "validates_acceptance_of if" do |snippet|
    snippet.trigger = "vaoif"
    # FIXME We can't handle nested snippets
    # snippet.expansion = "validates_acceptance_of :${1:terms}${2:${3:, :accept => '${4:1}'}${5:, :message => '${6:You must accept the terms of service}'}}, :if => proc { |obj| ${7:obj.condition?} }}"
    snippet.expansion = "validates_acceptance_of :${1:terms}, :accept => '${1}', :message => '${6:You must accept the terms of service}', :if => proc { |{7:obj}| ${7}.${8:condition?} }"
  end

  snippet "validates_acceptance_of" do |snippet|
    snippet.trigger = "vao"
    # FIXME We can't handle nested snippets
    # snippet.expansion = "validates_acceptance_of :${1:terms}${2:${3:, :accept => '${4:1}'}${5:, :message => '${6:You must accept the terms of service}'}}"
    snippet.expansion = "validates_acceptance_of :${1:terms}, :accept => '${1}', :message => '${6:You must accept the terms of service}'"
  end

  snippet "validates_associated" do |snippet|
    snippet.trigger = "va"
    # FIXME We can't handle nested snippets
    # snippet.expansion = "validates_associated :${1:attribute}${2:, :on => :${3:create}}"
    snippet.expansion = "validates_associated :${1:attribute}, :on => :${3:create}"
  end

  snippet "validates_associated if" do |snippet|
    snippet.trigger = "vaif"
    # FIXME We can't handle nested snippets
    # snippet.expansion = "validates_associated :${1:attribute}${2:, :on => :${3:create}}, :if => proc { |obj| ${5:obj.condition?} }}"
    snippet.expansion = "validates_associated :${1:attribute}, :on => :${3:create}, :if => proc { |obj| ${5:obj.condition?} }"
  end

  snippet "validates_confirmation_of" do |snippet|
    snippet.trigger = "vc"
    # FIXME We can't handle nested snippets
    # snippet.expansion = "validates_confirmation_of :${1:attribute}${2:, :on => :${3:create}, :message => '${4:should match confirmation}'}"
    snippet.expansion = "validates_confirmation_of :${1:attribute}, :on => :${3:create}, :message => '${4:should match confirmation}'"
  end

  snippet "validates_confirmation_of if" do |snippet|
    snippet.trigger = "vcif"
    # FIXME We can't handle nested snippets
    # snippet.expansion = "validates_confirmation_of :${1:attribute}${2:, :on => :${3:create}, :message => '${4:should match confirmation}'}, :if => proc { |obj| ${5:obj.condition?} }}"
    snippet.expansion = "validates_confirmation_of :${1:attribute}, :on => :${3:create}, :message => '${4:should match confirmation}'}, :if => proc { |obj| ${5:obj.condition?} }"
  end

  snippet "validates_exclusion_of" do |snippet|
    snippet.trigger = "ve"
    # FIXME We can't handle nested snippets
    # snippet.expansion = "validates_exclusion_of :${1:attribute}${2:, :in => ${3:%w( ${4:mov avi} )}, :on => :${5:create}, :message => '${6:extension %s is not allowed}'}"
    snippet.expansion = "validates_exclusion_of :${1:attribute}, :in => %w( ${4:mov avi} ), :on => :${5:create}, :message => '${6:extension %s is not allowed}'"
  end

  snippet "validates_format_of if" do |snippet|
    snippet.trigger = "vfif"
    # FIXME We can't handle nested snippets or transformations!
    # snippet.expansion = "validates_format_of :${1:attribute}, :with => /${2:^[${3:\w\d}]+\$}/${4:, :on => :${5:create}, :message => '${6:is invalid}'}, :if => proc { |obj| ${7:obj.condition?} }}"
    snippet.expansion = "validates_format_of :${1:attribute}, :with => /${2:^[\w\d]+\$}/, :on => :${5:create}, :message => '${6:is invalid}', :if => proc { |obj| ${7:obj.condition?} }"
  end

  snippet "validates_format_of" do |snippet|
    snippet.trigger = "vf"
    # FIXME We can't handle nested snippets or transformations!
    # snippet.expansion = "validates_format_of :${1:attribute}, :with => /${2:^[${3:\w\d}]+\$}/${4:, :on => :${5:create}, :message => '${6:is invalid}'}"
    snippet.expansion = "validates_format_of :${1:attribute}, :with => /${2:^[\w\d]+\$}/, :on => :${5:create}, :message => '${6:is invalid}'"
  end

  snippet "validates_inclusion_of if" do |snippet|
    snippet.trigger = "viif"
    # FIXME We can't handle nested snippets!
    # snippet.expansion = "validates_inclusion_of :${1:attribute}${2:, :in => ${3:%w( ${4:mov avi} )}, :on => :${5:create}, :message => '${6:extension %s is not included in the list}'}, :if => proc { |obj| ${7:obj.condition?} }}"
    snippet.expansion = "validates_inclusion_of :${1:attribute}, :in => %w( ${4:mov avi} ), :on => :${5:create}, :message => '${6:extension %s is not included in the list}', :if => proc { |obj| ${7:obj.condition?} }"
  end

  snippet "validates_inclusion_of" do |snippet|
    snippet.trigger = "vi"
    # FIXME We can't handle nested snippets!
    # snippet.expansion = "validates_inclusion_of :${1:attribute}${2:, :in => ${3:%w( ${4:mov avi} )}, :on => :${5:create}, :message => '${6:extension %s is not included in the list}'}"
    snippet.expansion = "validates_inclusion_of :${1:attribute}, :in => %w( ${4:mov avi} ), :on => :${5:create}, :message => '${6:extension %s is not included in the list}'"
  end

  snippet "validates_length_of" do |snippet|
    snippet.trigger = "vl"
    # FIXME We can't handle nested snippets!
    # snippet.expansion = "validates_length_of :${1:attribute}, :within => ${2:3..20}${3:, :on => :${4:create}, :message => '${5:must be present}'}"
    snippet.expansion = "validates_length_of :${1:attribute}, :within => ${2:3..20}, :on => :${4:create}, :message => '${5:must be present}'"
  end

  snippet "validates_length_of if" do |snippet|
    snippet.trigger = "vlif"
    # FIXME We can't handle nested snippets!
    # snippet.expansion = "validates_length_of :${1:attribute}, :within => ${2:3..20}${3:, :on => :${4:create}, :message => '${5:must be present}'}, :if => proc { |obj| ${6:obj.condition?} }}"
    snippet.expansion = "validates_length_of :${1:attribute}, :within => ${2:3..20}, :on => :${4:create}, :message => '${5:must be present}', :if => proc { |obj| ${6:obj.condition?} }"
  end

  snippet "validates_numericality_of" do |snippet|
    snippet.trigger = "vn"
    # FIXME We can't handle nested snippets!
    # snippet.expansion = "validates_numericality_of :${1:attribute}${2:, :on => :${3:create}, :message => '${4:is not a number}'}"
    snippet.expansion = "validates_numericality_of :${1:attribute}, :on => :${3:create}, :message => '${4:is not a number}'"
  end

  snippet "validates_numericality_of if" do |snippet|
    snippet.trigger = "vnif"
    # FIXME We can't handle nested snippets!
    # snippet.expansion = "validates_numericality_of :${1:attribute}${2:, :on => :${3:create}, :message => '${4:is not a number}'}, :if => proc { |obj| ${5:obj.condition?} }}"
    snippet.expansion = "validates_numericality_of :${1:attribute}, :on => :${3:create}, :message => '${4:is not a number}', :if => proc { |obj| ${5:obj.condition?} }"
  end

  snippet "validates_presence_of" do |snippet|
    snippet.trigger = "vp"
    # FIXME We can't handle nested snippets!
    # snippet.expansion = "validates_presence_of :${1:attribute}${2:, :on => :${3:create}, :message => '${4:can't be blank}'}"
    snippet.expansion = "validates_presence_of :${1:attribute}, :on => :${3:create}, :message => \"${4:can't be blank}\""
  end

  snippet "validates_presence_of if" do |snippet|
    snippet.trigger = "vpif"
    # FIXME We can't handle nested snippets!
    # snippet.expansion = "validates_exclusion_of :${1:attribute}${2:, :in => ${3:%w( ${4:mov avi} )}, :on => :${5:create}, :message => '${6:extension %s is not allowed}'}, :if => proc { |obj| ${5:obj.condition?} }"
    snippet.expansion = "validates_exclusion_of :${1:attribute}, :in => %w( ${4:mov avi} ), :on => :${5:create}, :message => '${6:extension %s is not allowed}', :if => proc { |obj| ${5:obj.condition?} }"
  end

  snippet "validates_uniqueness_of" do |snippet|
    snippet.trigger = "vu"
    # FIXME We can't handle nested snippets!
    # snippet.expansion = "validates_uniqueness_of :${1:attribute}${2:, :on => :${3:create}, :message => '${4:must be unique}'}"
    snippet.expansion = "validates_uniqueness_of :${1:attribute}, :on => :${3:create}, :message => '${4:must be unique}'"
  end

  snippet "validates_uniqueness_of if" do |snippet|
    snippet.trigger = "vuif"
    # FIXME We can't handle nested snippets!
    # snippet.expansion = "validates_uniqueness_of :${1:attribute}${2:, :on => :${3:create}, :message => '${4:must be unique}'}, :if => proc { |obj| ${6:obj.condition?} }}"
    snippet.expansion = "validates_uniqueness_of :${1:attribute}, :on => :${3:create}, :message => '${4:must be unique}'}, :if => proc { |obj| ${6:obj.condition?} }"
  end

end
