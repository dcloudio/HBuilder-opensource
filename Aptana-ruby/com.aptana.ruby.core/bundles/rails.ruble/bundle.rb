require 'ruble'

bundle do |bundle|
  bundle.display_name = t(:bundle_name)
  bundle.author = "Many"
  bundle.copyright = "Copyright 2010 Aptana Inc. Distributed under the MIT license.\nPortions Copyright 2006 syncPEOPLE, LLC, distributed under the terms of the MIT License."
  bundle.description = "Rails bundle for RadRails, based heavily on Dr. Nic's tmbundle (http://github.com/drnic/ruby-on-rails-tmbundle), which in turn was based heavily on the original SyncPeople bundle."
  bundle.repository = "git://github.com/aptana/rails.ruble.git"
  bundle.file_types['source.ruby.rails'] = "*.rb"

  bundle.menu t(:toplevel_menu) do |rails_menu|
    # this menu should be shown when any of the following scopes is active:
    rails_menu.scope = [ "source.ruby", "project.rails", 'source.yaml', 'text.haml', 'text.html.ruby' ]
    
    rails_menu.command t(:preview)
    rails_menu.separator    
    rails_menu.menu t(:go_to) do |goto_menu|
      goto_menu.command t(:go_to_alternate_file)
      goto_menu.command t(:go_to_file_on_current_line)
      goto_menu.separator
      goto_menu.command t(:go_to_model)
      goto_menu.command t(:go_to_view)
      goto_menu.command t(:go_to_controller)
      goto_menu.command t(:go_to_functional_test)
      goto_menu.command t(:go_to_helper)
      goto_menu.command t(:go_to_javascript)
      goto_menu.command t(:go_to_stylesheet)
      goto_menu.command t(:go_to_unit_test)
      goto_menu.command t(:go_to_fixture)
    end
    rails_menu.menu t(:run_tests) do |run_tests_menu|
      run_tests_menu.command t(:test_all)
      run_tests_menu.command t(:test_functionals)
      run_tests_menu.command t(:test_integration)
      run_tests_menu.command t(:test_plugins)
      run_tests_menu.command t(:test_recent)
      run_tests_menu.command t(:test_uncommitted)
      run_tests_menu.command t(:test_units)
    end
    rails_menu.separator
    rails_menu.command t(:call_generate_script)
    rails_menu.menu t(:database) do |db_menu|
      db_menu.command t(:migrate_to_current)
      db_menu.command t(:migrate_to_version)
      db_menu.command t(:migrate_to_previous_version)
      db_menu.command t(:redo_last_migration)
      db_menu.separator
      db_menu.command t(:load_fixtures_development)
      db_menu.command t(:load_fixtures_test)
      db_menu.separator
      db_menu.command t(:load_schema)
      db_menu.command t(:dump_db_to_schema)
      db_menu.command t(:clone_dev_db_to_test_db)
    end
    rails_menu.separator
    rails_menu.command "params[...]"
    rails_menu.command "session[...]"
    rails_menu.menu t(:logger) do |logger_menu|
      logger_menu.command "logger.debug"
      logger_menu.command "logger.info"
      logger_menu.command "logger.warn"
      logger_menu.command "logger.error"
      logger_menu.command "logger.fatal"
      logger_menu.command "RAILS_DEFAULT_LOGGER.debug"
    end
    rails_menu.separator
    rails_menu.menu t(:models) do |models_menu|
      models_menu.command t(:show_db_schema_for_class)
      models_menu.separator
      models_menu.command "alias_attribute"
      models_menu.separator
      models_menu.menu t(:callbacks) do |callbacks_menu|
        callbacks_menu.command "before_validation"
        callbacks_menu.command "before_validation_on_create"
        callbacks_menu.command "before_validation_on_update"
        callbacks_menu.command "after_validation"
        callbacks_menu.command "after_validation_on_create"
        callbacks_menu.command "after_validation_on_update"
        callbacks_menu.command "before_save"
        callbacks_menu.command "after_save"
        callbacks_menu.command "before_create"
        callbacks_menu.command "after_create"
        callbacks_menu.command "before_update"
        callbacks_menu.command "after_update"
        callbacks_menu.command "before_destroy"
        callbacks_menu.command "after_destroy"
      end
      models_menu.menu t(:associations) do |associations_menu|
        associations_menu.command "belongs_to"
        associations_menu.command "has_and_belongs_to_many"
        associations_menu.command "has_one"
        associations_menu.command "has_many"
        associations_menu.command "has_many :dependent => :destroy"
        associations_menu.command "has_many (through)"
        associations_menu.separator
        associations_menu.command "accepts_nested_attributes_for"
      end
      models_menu.menu t(:scopes) do |scopes_menu|
        scopes_menu.command "find(id)"
        scopes_menu.command "find(:all)"
        scopes_menu.command "find(:first)"
        scopes_menu.command "find(:last)"
        scopes_menu.command "find_in_batches"
        scopes_menu.separator
        scopes_menu.command "scoped_by"
      end
      models_menu.menu t(:finders) do |finders_menu|
        finders_menu.command "find(id)"
        finders_menu.command "find(:all)"
        finders_menu.command "find(:first)"
        finders_menu.command "find(:last)"
        finders_menu.command "find_in_batches"
        finders_menu.separator
        finders_menu.command "scoped_by"
      end
      models_menu.menu t(:validations) do |validations_menu|
        validations_menu.command "validates_acceptance_of"
        validations_menu.command "validates_acceptance_of if"
        validations_menu.command "validates_associated"
        validations_menu.command "validates_associated if"
        validations_menu.command "validates_confirmation_of"
        validations_menu.command "validates_confirmation_of if"
        validations_menu.command "validates_exclusion_of"
        validations_menu.command "validates_exclusion_of if"
        validations_menu.command "validates_inclusion_of"
        validations_menu.command "validates_inclusion_of if"
        validations_menu.command "validates_format_of"
        validations_menu.command "validates_format_of if"
        validations_menu.command "validates_length_of"
        validations_menu.command "validates_length_of if"
        validations_menu.command "validates_numericality_of"
        validations_menu.command "validates_numericality_of if"
        validations_menu.command "validates_presence_of"
        validations_menu.command "validates_presence_of if"
        validations_menu.command "validates_uniqueness_of"
        validations_menu.command "validates_uniqueness_of if"
      end
    end
    rails_menu.menu t(:controllers) do |controllers_menu|
      controllers_menu.command t(:create_controller)
      controllers_menu.command t(:create_resources_controller)
      controllers_menu.command "layout"
      controllers_menu.command "before_filter"
      controllers_menu.command "flash[...]"
      controllers_menu.menu "respond_to" do |respond_to_menu|
        respond_to_menu.command "respond_to (html)"
        respond_to_menu.command "respond_to"
        respond_to_menu.command "wants.format"
      end
      controllers_menu.menu "redirect_to" do |redirect_to_menu|
        redirect_to_menu.command "redirect_to (path)"
        redirect_to_menu.command "redirect_to (path plural)"
        redirect_to_menu.command "redirect_to (nested path)"
        redirect_to_menu.command "redirect_to (nested path plural)"
        redirect_to_menu.command "redirect_to (action)"
        redirect_to_menu.command "redirect_to (action, id)"
        redirect_to_menu.command "redirect_to (controller)"
        redirect_to_menu.command "redirect_to (controller, action)"
        redirect_to_menu.command "redirect_to (controller, action, id)"
        redirect_to_menu.command "redirect_to :back"
      end
      controllers_menu.menu "render" do |render_menu|
        render_menu.command "render (action)"
        render_menu.command "render (action, layout)"
        render_menu.command "render (file)"
        render_menu.command "render (file, use_full_path)"
        render_menu.command "render (inline)"
        render_menu.command "render (inline, locals)"
        render_menu.command "render (inline, type)"
        render_menu.command "render (layout)"
        render_menu.command "render (nothing)"
        render_menu.command "render (nothing, status)"
        render_menu.command "render (partial)"
        render_menu.command "render (partial, collection)"
        render_menu.command "render (partial, locals)"
        render_menu.command "render (partial, object)"
        render_menu.command "render (partial, status)"
        render_menu.command "render (text)"
        render_menu.command "render (text, layout)"
        render_menu.command "render (text, layout => true)"
        render_menu.command "render (text, status)"
        render_menu.command "render (update)"
      end
      controllers_menu.menu t(:rest_methods) do |rest_methods_menu|
        rest_methods_menu.command "def create - resource"
      end
      controllers_menu.separator
      controllers_menu.command "verify - render"
      controllers_menu.command "verify - redirect"
    end
    rails_menu.menu t(:view_templates) do |view_templates_menu|
      view_templates_menu.command t(:create_partial)
      view_templates_menu.separator
      view_templates_menu.command "form_for"
      view_templates_menu.command "form_for with errors"
      view_templates_menu.menu "form_for f.drop-down list" do |for_for_list_menu|
        for_for_list_menu.command "f.label (ffl)"
        for_for_list_menu.command "f.text_field (fftf)"
        for_for_list_menu.command "f.text_area (ffta)"
        for_for_list_menu.command "f.check_box (ffcb)"
        for_for_list_menu.command "f.radio_button (ffrb)"
        for_for_list_menu.command "f.password_field (ffpf)"
        for_for_list_menu.command "f.hidden_field (ffhf)"
        for_for_list_menu.command "f.file_field (ffff)"
        for_for_list_menu.command "f.submit (ffs)"
        for_for_list_menu.command "f.fields_for (nff)"
      end
      view_templates_menu.menu "form_for helpers" do |form_for_helpers_menu|
        form_for_helpers_menu.command "form_for label"
        form_for_helpers_menu.command "form_for text_field"
        form_for_helpers_menu.command "form_for text_area"
        form_for_helpers_menu.command "form_for check_box"
        form_for_helpers_menu.command "form_for radio_button"
        form_for_helpers_menu.command "form_for password_field"
        form_for_helpers_menu.command "form_for hidden_field"
        form_for_helpers_menu.command "form_for file_field"
        form_for_helpers_menu.command "form_for submit"
        form_for_helpers_menu.command "form_for fields_for"
      end
      view_templates_menu.command "fields_for"      
      view_templates_menu.separator      
      view_templates_menu.command "form_tag"
      view_templates_menu.command "submit_tag"
      view_templates_menu.command "image_submit_tag"
      view_templates_menu.menu "link_to" do |link_to_menu|
        link_to_menu.command "link_to (path)"
        link_to_menu.command "link_to (path plural)"
        link_to_menu.command "link_to (nested path)"
        link_to_menu.command "link_to (nested path plural)"
        link_to_menu.command "link_to (action)"
        link_to_menu.command "link_to (action, id)"
        link_to_menu.command "link_to (controller)"
        link_to_menu.command "link_to (controller, action)"
        link_to_menu.command "link_to (controller, action, id)"
        link_to_menu.command "link_to model"
      end
      view_templates_menu.command "end (ERB)"      
      view_templates_menu.separator      
      view_templates_menu.command "map(&:sym_proc)"      
      view_templates_menu.separator      
      view_templates_menu.command "content_for"
      view_templates_menu.command t(:for_loop_rhtml)
    end
    rails_menu.menu t(:layouts) do |layouts_menu|
      layouts_menu.command "javascript_include_tag"
      layouts_menu.command "stylesheet_link_tag"
    end
    rails_menu.menu "RJS" do |rjs_menu|
      rjs_menu.command "page.replace (id, partial)"
      rjs_menu.command "page.hide (*ids)"
      rjs_menu.command "page.replace_html (id, partial)"
      rjs_menu.command "page.insert_html (position, id, partial)"
      rjs_menu.command "page.visual_effect (effect, id)"
      rjs_menu.command "page.show (*ids)"
      rjs_menu.command "page.toggle (*ids)"
    end
    rails_menu.menu t(:migrations) do |migrations_menu|
      migrations_menu.menu t(:columns) do |columns_menu|
        columns_menu.command t(:add_remove_column)
        columns_menu.command t(:add_remove_several_columns)
        columns_menu.command t(:add_remove_several_columns_1)
        columns_menu.command t(:add_remove_timestamps)
        columns_menu.command t(:change_column)
        columns_menu.command t(:change_column_default)
        columns_menu.command t(:rename_column)
        columns_menu.command t(:rename_several_columns)
        columns_menu.command t(:rename_several_columns_1)
        columns_menu.command t(:remove_add_column)
        columns_menu.command t(:remove_add_timestamps)
      end
      migrations_menu.menu t(:tables) do |tables_menu|
        tables_menu.command t(:create_drop_table)
        tables_menu.command t(:rename_table)
        tables_menu.command t(:drop_create_table)
        tables_menu.command t(:change_table)    
        # tables_menu.menu "Create columns t. drop-down list" do |create_columns_list_menu|
        #   create_columns_list_menu.command "t.string (tcs)"
        #   create_columns_list_menu.command "t.text (tct)"
        #   create_columns_list_menu.command "t.integer (tci)"
        #   create_columns_list_menu.command "t.float (tcf)"
        #   create_columns_list_menu.command "t.decimal (tcd)"
        #   create_columns_list_menu.command "t.datetime (tcdt)"
        #   create_columns_list_menu.command "t.timestamp (tcts)"
        #   create_columns_list_menu.command "t.time (tcti)"
        #   create_columns_list_menu.command "t.date (tcda)"
        #   create_columns_list_menu.command "t.boolean (tcb)"
        #   create_columns_list_menu.command "t.binary (tcbi)"
        #   create_columns_list_menu.command "t.timestamps (tctss)"
        #   create_columns_list_menu.command "t.lock_version (tcl)"
        #   create_columns_list_menu.command "t.references (tcr)"
        # end
        tables_menu.menu t(:create_columns_helpers) do |create_columns_helpers_menu|
          create_columns_helpers_menu.command t(:table_column_string)
          create_columns_helpers_menu.command t(:table_column_text)
          create_columns_helpers_menu.command t(:table_column_integer)
          create_columns_helpers_menu.command t(:table_column_float)
          create_columns_helpers_menu.command t(:table_column_decimal)
          create_columns_helpers_menu.command t(:table_column_datetime)
          create_columns_helpers_menu.command t(:table_column_timestamp)
          create_columns_helpers_menu.command t(:table_column_time)
          create_columns_helpers_menu.command t(:table_column_date)
          create_columns_helpers_menu.command t(:table_column_boolean)
          create_columns_helpers_menu.command t(:table_column_binary)
          create_columns_helpers_menu.command t(:table_column_timestamps)
          create_columns_helpers_menu.command t(:table_column_lock_version)
          create_columns_helpers_menu.command t(:table_column_references)
        end
        tables_menu.command t(:create_column_in_table)
        # tables_menu.command "Create Several Columns in Table"
        tables_menu.menu t(:change_columns_drop_down) do |change_columns_list_menu|
          change_columns_list_menu.command "t.change (tch)"
          change_columns_list_menu.command "t.rename (tre)"
        end
        tables_menu.menu t(:change_columns_helpers) do |change_columns_helper_menu|
          change_columns_helper_menu.command t(:table_column_change)
          change_columns_helper_menu.command t(:table_column_rename)
        end
      end
      migrations_menu.menu t(:indices) do |indices_menu|
        indices_menu.command t(:add_remove_index)
        indices_menu.command t(:add_remove_named_index)
        indices_menu.command t(:add_remove_unique_index)
      end
    end
    rails_menu.menu t(:environment) do |environment_menu|
      environment_menu.command "config.gem"
    end
    rails_menu.menu t(:routes) do |routes_menu|
      routes_menu.command "map.named_route"
      routes_menu.command "map.resources"
      routes_menu.command "map.resource"
      routes_menu.command "map.with_options"
      routes_menu.command "map.catch_all"
    end
    rails_menu.menu "ActiveSupport" do |active_support_menu|
      active_support_menu.command "cattr_accessor"
      active_support_menu.command "mattr_accessor"
      active_support_menu.command "returning do |variable| ... end"
    end
    rails_menu.separator
    rails_menu.menu t(:fixtures) do |fixtures_menu|
      fixtures_menu.command "$LABEL"
      fixtures_menu.command "<%= Fixtures.identify(:symbol) %>"
      fixtures_menu.separator
      fixtures_menu.command t(:autocomplete_foreign_key_fixture)
      fixtures_menu.command t(:autocomplete_foreign_key_fixture_1)
    end
    rails_menu.command "test do...end"
    rails_menu.menu t(:unit_tests) do |unit_tests_menu|
      unit_tests_menu.command "assert_difference"
      unit_tests_menu.command "assert_no_difference"
    end
    rails_menu.menu t(:functional_tests) do |functional_tests_menu|
      functional_tests_menu.command t(:create_functional_test_class)
      functional_tests_menu.command "def test_should_get_action"
      functional_tests_menu.command "def test_should_post_action"
      functional_tests_menu.separator
      functional_tests_menu.command "assert_response"
      functional_tests_menu.command "assert_redirected_to"
      functional_tests_menu.command "assert_redirected_to (path)"
      functional_tests_menu.command "assert_redirected_to (path plural)"
      functional_tests_menu.command "assert_redirected_to (nested path)"
      functional_tests_menu.command "assert_redirected_to (nested path plural)"
      functional_tests_menu.separator
      functional_tests_menu.command "assert_select"
      functional_tests_menu.separator
      functional_tests_menu.command "assert_rjs"
      functional_tests_menu.separator
      functional_tests_menu.command "assert(var= assigns(:var))"
    end
    rails_menu.menu t(:ajax_tests) do |ajax_tests_menu|
      ajax_tests_menu.command "xhr post"
      ajax_tests_menu.command "xhr get"
      ajax_tests_menu.command "xhr delete"
      ajax_tests_menu.command "xhr put"
    end
    rails_menu.separator
    rails_menu.command t(:docs_for_word)
    rails_menu.command "find_each"
    rails_menu.command t(:list_columns_of_model)
  end
end

# Set up special variables for some commands for ERB/HAML
env "text.html.ruby" do |e|
  e['TM_RAILS_TEMPLATE_START_RUBY_EXPR'] = "<%= "
  e['TM_RAILS_TEMPLATE_END_RUBY_EXPR'] = " %>"
  e['TM_RAILS_TEMPLATE_START_RUBY_INLINE'] = "<% "
  e['TM_RAILS_TEMPLATE_END_RUBY_INLINE'] = " -%>"
  e['TM_RAILS_TEMPLATE_END_RUBY_BLOCK'] = "<% end -%>"
end
env "text.haml" do |e|
  e['TM_RAILS_TEMPLATE_START_RUBY_EXPR'] = "= "
  e['TM_RAILS_TEMPLATE_END_RUBY_EXPR'] = ""
  e['TM_RAILS_TEMPLATE_START_RUBY_INLINE'] = "- "
  e['TM_RAILS_TEMPLATE_END_RUBY_INLINE'] = ""
  e['TM_RAILS_TEMPLATE_END_RUBY_BLOCK'] = ""
end

# Auto-closing pairs
smart_typing_pairs["text.html.ruby"] = ['%', '%', '"', '"', '(', ')', '{', '}', '[', ']', '<', '>']
smart_typing_pairs["text.html.ruby meta.tag"] = ['%', '%', '"', '"', '(', ')', '{', '}', '[', ']', '<', '>', "'", "'"]
smart_typing_pairs["text.html.ruby meta.tag string"] = ['"', '"', '(', ')', '{', '}', '[', ']', '%', '%', '<', '>']

# Misc code for preview...
module Ruble
  class Project
    # Add a method allowing commands to get root URL of server for project...
    def root_url
      port = 3000
      host = "localhost"
      # Only scan processes on non-windows platforms
      if !Ruble.platforms.include? :windows
        # Rails 2.x
        # FIXME This doesn't have the project location in the args!
        out = IO.popen('ps wwax -o args | grep "script/server"', 'r') {|io| io.read } || ''
        out.each_line do |line|
          words = line.split(' ')
          next if words.first == 'grep'
          # Ok we need to search the words starting at index 2, look for --port or -p
          words = words[2..-1]
          next if words.nil?
          words = words[(words.index("--") + 1)..-1] while words.include?("--")
          words.each_with_index do |word, i|
            port = words[i + 1] if word == "-p" || word == "--port"
            # TODO What if they used --switch=value format?
            host = words[i + 1] if word == "-b" || word == "--binding"
          end
        end
        # Rails 3.x
        out = IO.popen('ps wwax -o args | grep "rails server"', 'r') {|io| io.read } || ''
        out.each_line do |line|
          words = line.split(' ')
          next if words.first == 'grep'
          next unless words[1].start_with? to_dir.path # looks like it's this project
          # Ok we need to search the words starting at index 2, look for --port or -p
          words = words[2..-1]
          next if words.nil?
          words = words[(words.index("--") + 1)..-1] while words.include?("--")
          words.each_with_index do |word, i|
            port = words[i + 1] if word == "-p" || word == "--port"
            # TODO What if they used --switch=value format?
            host = words[i + 1] if word == "-b" || word == "--binding"
          end
        end
      end
      # TODO if host is 0.0.0.0 or 127.0.0.1, change to localhost or something?
      "http://#{host}:#{port}/"
    end
  end
end