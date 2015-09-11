require 'ruble'
require 'ruble/terminal'

with_defaults :scope => "source.ruby.rails, source.yaml",
              #:key_binding => "CONTROL+\\",
              :output => :discard do |bundle|
  command t(:test_all) do |cmd|
    cmd.invoke {|context|  Ruble::Terminal.open("rake test", context.project.to_dir.path) }
  end

  command t(:test_functionals) do |cmd|
    cmd.invoke {|context|  Ruble::Terminal.open("rake test:functionals", context.project.to_dir.path) }
  end

  command t(:test_integration) do |cmd|
    cmd.invoke {|context|  Ruble::Terminal.open("rake test:integration", context.project.to_dir.path) }
  end

  command t(:test_plugins) do |cmd|
    cmd.invoke {|context|  Ruble::Terminal.open("rake test:plugins", context.project.to_dir.path) }
  end

  command t(:test_recent) do |cmd|
    cmd.invoke {|context|  Ruble::Terminal.open("rake test:recent", context.project.to_dir.path) }
  end

  command t(:test_uncommitted) do |cmd|
    cmd.invoke {|context|  Ruble::Terminal.open("rake test:uncommitted", context.project.to_dir.path) }
  end

  command t(:test_units) do |cmd|
    cmd.invoke {|context|  Ruble::Terminal.open("rake test:units", context.project.to_dir.path) }
  end

end