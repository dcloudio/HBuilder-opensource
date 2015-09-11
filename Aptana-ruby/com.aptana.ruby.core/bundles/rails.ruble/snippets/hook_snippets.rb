require 'ruble'

with_defaults :scope => "source.ruby.rails" do |bundle|

  snippet "after_create" do |snippet|
    snippet.trigger = "aftc"
    snippet.expansion = "after_create "
  end

  snippet "after_destroy" do |snippet|
    snippet.trigger = "aftd"
    snippet.expansion = "after_destroy "
  end

  snippet "after_save" do |snippet|
    snippet.trigger = "afts"
    snippet.expansion = "after_save "
  end

  snippet "after_update" do |snippet|
    snippet.trigger = "aftu"
    snippet.expansion = "after_update "
  end

  snippet "after_validation" do |snippet|
    snippet.trigger = "aftv"
    snippet.expansion = "after_validation "
  end

  snippet "after_validation_on_create" do |snippet|
    snippet.trigger = "aftvoc"
    snippet.expansion = "after_validation_on_create "
  end

  snippet "after_validation_on_update" do |snippet|
    snippet.trigger = "aftvou"
    snippet.expansion = "after_validation_on_update "
  end

  snippet "before_create" do |snippet|
    snippet.trigger = "befc"
    snippet.expansion = "before_create "
  end

  snippet "before_destroy" do |snippet|
    snippet.trigger = "befd"
    snippet.expansion = "before_destroy "
  end

  snippet "before_filter" do |snippet|
    snippet.trigger = "bf"
    snippet.expansion = "before_filter "
  end

  snippet "before_save" do |snippet|
    snippet.trigger = "befs"
    snippet.expansion = "before_save "
  end

  snippet "before_update" do |snippet|
    snippet.trigger = "befu"
    snippet.expansion = "before_update "
  end

  snippet "before_validation" do |snippet|
    snippet.trigger = "befv"
    snippet.expansion = "before_validation "
  end

  snippet "before_validation_on_create" do |snippet|
    snippet.trigger = "befvoc"
    snippet.expansion = "before_validation_on_create "
  end

  snippet "before_validation_on_update" do |snippet|
    snippet.trigger = "befvou"
    snippet.expansion = "before_validation_on_update "
  end

end

