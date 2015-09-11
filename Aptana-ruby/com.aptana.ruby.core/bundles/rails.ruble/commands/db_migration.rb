require 'ruble'

with_defaults :scope => "source.ruby.rails, source.yaml",
              :output => :discard do |bundle|
  require 'ruble/terminal'
  
  command t(:clone_dev_db_to_test_db) do |cmd|
    cmd.invoke {|context|  Ruble::Terminal.open("rake db:test:clone", context.project.to_dir.path) }
  end

  command t(:dump_db_to_schema) do |cmd|
    cmd.invoke {|context|  Ruble::Terminal.open("rake db:schema:dump", context.project.to_dir.path) }
  end

  command t(:load_schema) do |cmd|
    cmd.invoke {|context|  Ruble::Terminal.open("rake db:schema:load", context.project.to_dir.path) }
  end

  # FIXME: generate quick migration?

  command t(:load_fixtures_test) do |cmd|
    cmd.invoke {|context|  Ruble::Terminal.open("rake db:fixtures:load RAILS_ENV=test", context.project.to_dir.path) }
  end

  command t(:load_fixtures_development) do |cmd|
    cmd.invoke {|context|  Ruble::Terminal.open("rake db:fixtures:load", context.project.to_dir.path) }
  end

  command t(:migrate_to_previous_version) do |cmd|
    cmd.invoke do |context|
      # FIXME: need to do this in RUBY directly
      current_schema_version = "0" #`grep 'Schema\.define' "$TM_PROJECT_DIRECTORY/db/schema.rb" | ruby -e 'print $stdin.read.scan(/\d+/).first'`
      Ruble::Terminal.open("rake db:migrate:down VERSION=#{current_schema_version}", context.project.to_dir.path)
    end
  end

  # Migrate to version is in textmate, but sucks. we can do better with a gui...
  command t(:migrate_to_current) do |cmd|
    cmd.invoke {|context|  Ruble::Terminal.open("rake db:migrate", context.project.to_dir.path) }
  end

  command t(:redo_last_migration) do |cmd|
    cmd.invoke {|context|  Ruble::Terminal.open("rake db:migrate:redo", context.project.to_dir.path) }
  end
end

# FIXME textmate macro has scopeType=local. what is our equivalent?
with_defaults :scope => "source.ruby.rails",
#:scope => "meta.rails.migration - meta.rails.migration.create_table - meta.rails.migration.change_table",
              :input => :selection,
              :output => :insert_as_snippet do |bundle|
  
  command t(:add_remove_column) do |cmd|
    # cmd.extend IntelligentMigration
    cmd.trigger = "mcol"
    cmd.invoke {|context| require 'rails/intelligent_migration'; IntelligentMigration.process_migration(context, :add_remove_column) }
  end

  command t(:add_remove_index) do |cmd|
    cmd.trigger = "mind"  
    cmd.invoke {|context| require 'rails/intelligent_migration'; IntelligentMigration.process_migration(context, :add_remove_index) }
  end

  command t(:add_remove_named_index) do |cmd|
    cmd.trigger = "mind"
    cmd.invoke {|context| require 'rails/intelligent_migration'; IntelligentMigration.process_migration(context, :add_remove_named_index) }
  end

  command t(:add_remove_several_columns_1) do |cmd|
    cmd.trigger = "marcc"
    cmd.invoke {|context| require 'rails/intelligent_migration'; IntelligentMigration.process_migration(context, :add_remove_column_continue) }
  end

  command t(:add_remove_several_columns) do |cmd|
    cmd.trigger = "mcol"
    cmd.invoke {|context| require 'rails/intelligent_migration'; IntelligentMigration.process_migration(context, :add_remove_column_continue) }
  end

  command t(:add_remove_timestamps) do |cmd|
    cmd.trigger = "mcol"
    cmd.invoke {|context| require 'rails/intelligent_migration'; IntelligentMigration.process_migration(context, :add_remove_timestamps) }
  end

  command t(:add_remove_unique_index) do |cmd|
    cmd.trigger = "mind"
    cmd.invoke {|context| require 'rails/intelligent_migration'; IntelligentMigration.process_migration(context, :add_remove_unique_index) }
  end

  command t(:change_table)  do |cmd|
    cmd.trigger = "mtab"    
    cmd.invoke {|context| require 'rails/intelligent_migration'; IntelligentMigration.process_migration(context, :change_change_table) }
  end

  command t(:change_column_default) do |cmd|
    cmd.trigger = "mcol"
    cmd.invoke {|context| require 'rails/intelligent_migration'; IntelligentMigration.process_migration(context, :change_column_default) }
  end

  command t(:change_column) do |cmd|
    cmd.trigger = "mcol"
    cmd.invoke {|context| require 'rails/intelligent_migration'; IntelligentMigration.process_migration(context, :change_column) }
  end

  command t(:create_drop_table) do |cmd|
    cmd.trigger = "mtab"
    cmd.invoke {|context| require 'rails/intelligent_migration'; IntelligentMigration.process_migration(context, :create_drop_table) }
  end

  command t(:remove_add_timestamps) do |cmd|
    cmd.trigger = "mcol"
    cmd.invoke {|context| require 'rails/intelligent_migration'; IntelligentMigration.process_migration(context, :remove_add_timestamps) }
  end

  command t(:rename_several_columns_1) do |cmd|
    cmd.trigger = "mncc"
    cmd.invoke {|context| require 'rails/intelligent_migration'; IntelligentMigration.process_migration(context, :rename_column_continue) }
  end

  command t(:rename_several_columns) do |cmd|
    cmd.trigger = "mcol"
    cmd.invoke {|context| require 'rails/intelligent_migration'; IntelligentMigration.process_migration(context, :rename_column_continue) }
  end

  command t(:rename_column) do |cmd|
    cmd.trigger = "mcol"
    cmd.invoke {|context| require 'rails/intelligent_migration'; IntelligentMigration.process_migration(context, :rename_column) }
  end

  command t(:rename_table) do |cmd|
    cmd.trigger = "mtab"
    cmd.invoke {|context| require 'rails/intelligent_migration'; IntelligentMigration.process_migration(context, :rename_table) }
  end

end
