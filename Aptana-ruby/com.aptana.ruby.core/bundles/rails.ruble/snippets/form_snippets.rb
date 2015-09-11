require 'ruble'

with_defaults :scope => "text.html.ruby, text.haml" do |bundle|

  snippet "form_for check_box" do |snippet|
    snippet.trigger = [ "f.", "ffcb" ]
    snippet.expansion = "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.check_box :${1:attribute}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"
  end

  snippet "form_for fields_for" do |snippet|
    snippet.trigger = [ "f.", "nff" ]
    snippet.expansion = "${TM_RAILS_TEMPLATE_START_RUBY_INLINE}f.fields_for :${1:attribute} do |${2:f}|${TM_RAILS_TEMPLATE_END_RUBY_INLINE}
  $0
${TM_RAILS_TEMPLATE_END_RUBY_BLOCK}"
  end

  snippet "form_for file_field" do |snippet|
    snippet.trigger = [ "f.", "ffff" ]
    snippet.expansion = "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.file_field :${1:attribute}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"
  end

  snippet "form_for hidden_field" do |snippet|
    snippet.trigger = [ "f.", "ffhf" ]
    snippet.expansion = "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.hidden_field :${1:attribute}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"
  end

  snippet "form_for label" do |snippet|
    snippet.trigger = [ "f.", "ffl" ]
    # FIXME We don't support nested tabstops or transformations
    #snippet.expansion = "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.label :${1:attribute}${2:, \"${3:${1/[[:alpha:]]+|(_)/(?1: :\u$0)/g}}\"}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"
    snippet.expansion = "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.label :${1:attribute}, \"${1}\"${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"
  end

  snippet "form_for password_field" do |snippet|
    snippet.trigger = [ "f.", "ffpf" ]
    snippet.expansion = "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.password_field :${1:attribute}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"
  end

  snippet "form_for radio_button" do |snippet|
    snippet.trigger = [ "f.", "ffrb" ]
    snippet.expansion = "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.radio_button :${1:attribute}, :${2:tag_value}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"
  end

  snippet "form_for submit" do |snippet|
    snippet.trigger = [ "f.", "ffs" ]
    # FIXME We don't support nested tabstops
    #snippet.expansion = "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.submit \"${1:Submit}\"${2:, :disable_with => '${3:$1ing...}'}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"
    snippet.expansion = "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.submit \"${1:Submit}\", :disable_with => '$1ing...'${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"
  end

  snippet "form_for text_area" do |snippet|
    snippet.trigger = [ "f.", "ffta" ]
    snippet.expansion = "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.text_area :${1:attribute}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"
  end

  snippet "form_for text_field" do |snippet|
    snippet.trigger = [ "f.", "fftf" ]
    snippet.expansion = "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.text_field :${1:attribute}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"
  end

  snippet "form_for with errors" do |snippet|
    snippet.trigger = "ffe"
    snippet.expansion = "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}error_messages_for :${1:model}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}\n${TM_RAILS_TEMPLATE_START_RUBY_INLINE}form_for @$1 do |f|${TM_RAILS_TEMPLATE_END_RUBY_INLINE}\n  $0\n${TM_RAILS_TEMPLATE_END_RUBY_BLOCK}"
  end

  snippet "form_for" do |snippet|
    snippet.trigger = "ff"
    snippet.expansion = "${TM_RAILS_TEMPLATE_START_RUBY_INLINE}form_for @${1:model} do |f|${TM_RAILS_TEMPLATE_END_RUBY_INLINE}\n  $0\n${TM_RAILS_TEMPLATE_END_RUBY_BLOCK}"
  end
  
  snippet "fields_for" do |cmd|
    cmd.trigger = "fields"
    cmd.expansion = "${TM_RAILS_TEMPLATE_START_RUBY_INLINE}fields_for :${1:model}, @$1 do |$1|${TM_RAILS_TEMPLATE_END_RUBY_INLINE}
  $0
${TM_RAILS_TEMPLATE_END_RUBY_BLOCK}"
  end

end
