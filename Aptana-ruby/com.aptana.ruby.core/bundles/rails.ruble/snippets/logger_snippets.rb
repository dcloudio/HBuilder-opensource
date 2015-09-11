require 'ruble'

with_defaults :scope => "source.ruby.rails" do |bundle|

  snippet "logger.debug" do |snippet|
    snippet.trigger = "logd"
    snippet.expansion = "logger.debug { \"${1:message}\" }$0"
  end

  snippet "logger.error" do |snippet|
    snippet.trigger = "loge"
    snippet.expansion = "logger.error { \"${1:message}\" }$0"
  end

  snippet "logger.fatal" do |snippet|
    snippet.trigger = "logf"
    snippet.expansion = "logger.fatal { \"${1:message}\" }$0"
  end

  snippet "logger.info" do |snippet|
    snippet.trigger = "logi"
    snippet.expansion = "logger.info { \"${1:message}\" }$0"
  end

  snippet "logger.warn" do |snippet|
    snippet.trigger = "logw"
    snippet.expansion = "logger.warn { \"${1:message}\" }$0"
  end

  snippet "RAILS_DEFAULT_LOGGER.debug" do |snippet|
    snippet.trigger = "rdb"
    snippet.expansion = "RAILS_DEFAULT_LOGGER.debug { \"${1:message}\" }$0"
  end

end