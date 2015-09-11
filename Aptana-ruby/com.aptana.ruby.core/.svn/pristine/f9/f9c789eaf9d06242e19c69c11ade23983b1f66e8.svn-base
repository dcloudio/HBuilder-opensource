require 'ruble'

with_defaults :output => :show_as_tooltip do |bundle|
             #:key_binding => "M1+M2+M3+ARROW_DOWN",

  command t(:go_to_controller) do |cmd|
    cmd.scope = "source.ruby, text.html.ruby, source.ruby.rails.embedded.html, meta.rails.helper, meta.rails.functional_test, source.js, source.css, source.yaml, meta.rails.model, meta.rails.unit_test, text.haml"
    cmd.invoke { require 'rails/command_go_to_file'; CommandGoToFile.alternate(:controller) }
  end

  command t(:go_to_alternate_file) do |cmd|
    cmd.scope = "source.ruby.rails, text.html.ruby, source.ruby.rails.embedded.html, source.yaml, text.haml, source.css, source.js, source.sass"
    cmd.invoke { require 'rails/command_go_to_file'; CommandGoToFile.alternate(nil) }
  end

  command t(:go_to_file_on_current_line) do |cmd|
    cmd.scope = "source.ruby.rails, text.html.ruby, source.ruby.rails.embedded.html, text.haml"
    cmd.invoke { require 'rails/command_go_to_file'; CommandGoToFile.on_current_line }
  end

  command t(:go_to_fixture) do |cmd|
    cmd.scope = "meta.rails.controller, meta.rails.helper, meta.rails.model, meta.rails.unit_test, meta.rails.functional_test"
    cmd.invoke { require 'rails/command_go_to_file'; CommandGoToFile.alternate(:fixture) }
  end

  command t(:go_to_functional_test) do |cmd|
    cmd.scope = "meta.rails.controller, meta.rails.helper, meta.rails.model, source.yaml, meta.rails.unit_test"
    cmd.invoke { require 'rails/command_go_to_file'; CommandGoToFile.alternate(:functional_test) }
  end

  command t(:go_to_helper) do |cmd|
    cmd.scope = "text.html.ruby, source.ruby.rails.embedded.html, meta.rails.controller, meta.rails.model, meta.rails.unit_test, meta.rails.functional_test, text.haml"
    cmd.invoke { require 'rails/command_go_to_file'; CommandGoToFile.alternate(:helper) }
  end

  command t(:go_to_javascript) do |cmd|
    cmd.scope = "text.html.ruby, source.ruby.rails.embedded.html, meta.rails.controller, meta.rails.helper, text.haml"
    cmd.invoke { require 'rails/command_go_to_file'; CommandGoToFile.alternate(:javascript) }
  end

  command t(:go_to_model) do |cmd|
    cmd.scope = "text.html.ruby, source.ruby.rails.embedded.html, meta.rails.helper, meta.rails.unit_test, source.js, source.css, source.yaml, meta.rails.controller, meta.rails.functional_test, text.haml"
    cmd.invoke { require 'rails/command_go_to_file'; CommandGoToFile.alternate(:model) }
  end

  command t(:go_to_stylesheet) do |cmd|
    cmd.scope = "text.html.ruby, source.ruby.rails.embedded.html, meta.rails.controller, meta.rails.helper, text.haml"
    cmd.invoke { require 'rails/command_go_to_file'; CommandGoToFile.alternate(:stylesheet) }
  end

  command t(:go_to_unit_test) do |cmd|
    cmd.scope = "meta.rails.controller, meta.rails.helper, meta.rails.model, meta.rails.functional_test, source.yaml"
    cmd.invoke { require 'rails/command_go_to_file'; CommandGoToFile.alternate(:unit_test) }
  end

  command t(:go_to_view) do |cmd|
    cmd.scope = "meta.rails.controller, meta.rails.mailer, source.js, source.css"
    cmd.invoke { require 'rails/command_go_to_file'; CommandGoToFile.alternate(:view) }
  end

end
