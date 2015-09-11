require 'ruble'

snippet "accepts_nested_attributes_for" do |snippet|
  snippet.trigger = "anaf"
  # FIXME We don't support nested tab stops
  #snippet.expansion = "accepts_nested_attributes_for :${1:association_name}${2:${3:, :allow_destroy => true}${4:, :reject_if => proc { |obj| ${5:obj.blank?} \}}}\n"
  snippet.expansion = "accepts_nested_attributes_for :${1:association_name}, :allow_destroy => true, :reject_if => proc { |obj| ${2:obj.blank?} \}\n"
  snippet.scope = [ :source_ruby_rails ]
end
