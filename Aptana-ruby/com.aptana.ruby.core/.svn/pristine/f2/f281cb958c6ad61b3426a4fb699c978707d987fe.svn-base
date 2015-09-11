#!/usr/bin/env ruby
#
# Copyright (c) 2006 Sami Samhuri
# Distributed under the MIT license
#
# Inserts a migration snippet into 2 places in the document, one
# piece in self.up and one in self.down.

module IntelligentMigration

  @@snippets = {
    :rename_column =>
      { :up   => 'rename_column :${1:table_name}, :${2:column_name}, :${3:new_column_name}$0',
        :down => 'rename_column :$1, :$3, :$2' },

    :rename_column_continue =>
      { :up   => 'rename_column :${1:table_name}, :${2:column_name}, :${3:new_column_name}
  mncc$0',
        :down => 'rename_column :$1, :$3, :$2' },

    :rename_table =>
      { :up   => 'rename_table :${1:old_table_name}, :${2:new_table_name}$0',
        :down => 'rename_table :$2, :$1' },

    :rename_table_continue =>
      { :up   => 'rename_table :${1:old_table_name}, :${2:new_table_name}
  mntc$0',
        :down => 'rename_table :$2, :$1' },
  
    :change_column =>
      { :up   => 'change_column :${1:table_name}, :${2:column_name}, :${4:string}$5',
        :down => 'change_column :$1, :$2, :${6:string}$7' },
 
    :change_column_default =>
     # FIXME Uncomment when we support nested tab stops
      # { :up   => 'change_column_default :\${1:table_name}, :\${2:column_name}, \${4:"\${5:new default}"}',
      #   :down => 'change_column_default :\$1, :\$2, \${6:"\${7:old default}"}' },
      { :up   => 'change_column_default :${1:table_name}, :${2:column_name}, "${4:new default}"',
        :down => 'change_column_default :$1, :$2, ${6:"old default"}' },

    :add_remove_column =>
      { :up   => 'add_column :${1:table_name}, :${2:column_name}, :${3:string}$0',
        :down => 'remove_column :$1, :$2' },

    :add_remove_column_continue =>
      { :up   => 'add_column :${1:table_name}, :${2:column_name}, :${3:string}
  marcc$0',
        :down => 'remove_column :$1, :$2' },

    :add_remove_timestamps =>
      { :up   => 'add_timestamps :${1:table_name}$0',
        :down => 'remove_timestamps :$1' },

    :remove_add_timestamps =>
      { :up   => 'remove_timestamps :${1:table_name}$0',
        :down => 'add_timestamps :$1' },

    :create_drop_table =>
      { :up   => 'create_table :${1:table_name}, :force => true do |t|
    t.$0
    t.timestamps
  end',
        :down => 'drop_table :$1' },

    :change_change_table =>
      { :up   => 'change_table :${1:table_name} do |t|
    t.$0
  end',
        :down => 'change_table :$1 do |t|
  end' },

    :add_remove_index =>
      { :up   => 'add_index :${1:table_name}, :${2:column_name}$0',
        :down => 'remove_index :$1, :$2' },

    :add_remove_unique_index =>
      # FIXME Uncomment when we support nested tab stops
      # { :up   => 'add_index :${1:table_name}, ${2:[:${3:column_name}${4:, :${5:column_name}}]}, :unique => true$0',
      #   :down => 'remove_index :$1, :column => $2' },
      { :up   => 'add_index :${1:table_name}, ${2:[:column_name, :column_name]}, :unique => true$0',
        :down => 'remove_index :$1, :column => $2' },

    :add_remove_named_index =>
      # FIXME Uncomment when we support nested tab stops
      # { :up   => 'add_index :${1:table_name}, [:${2:column_name}${3:, :${4:column_name}}], :name => "${5:index_name}"${6:, :unique => true}$0',
      #         :down => 'remove_index :$1, :name => :$5' }
      { :up   => 'add_index :${1:table_name}, [:${2:column_name, :column_name}], :name => "${5:index_name}"${6:, :unique => true}$0',
        :down => 'remove_index :$1, :name => :$5' }
  }

  def self.indent(code)
    lines = code.to_a.collect { |s| "\t\t" + s }
    lines.to_s + "\n"
  end

  def self.insert_migration(context, snippet, text)
    lines = text.to_a

    up_code = indent(snippet[:up])
    down_code = indent(snippet[:down])

    # insert the self.up part of the snippet
    lines[0] = up_code

    # find the beginning of self.down and insert down code, this is hardly robust.
    # assuming self.down is after self.up in the class
    lines.each_with_index do |line, i|
      if line =~ /^\s*def\s+self\.down\b/
        lines[i, 1] = [lines[i], down_code]
        break
      end
    end
    lines.to_s
  end

  def self.process_migration(context, snippet)
    # delete the text that triggered the snippet, then select from current line to end of document
    # context.editor.delete_word_left # FIXME Implement!
    line = context.editor.styled_text.line_at_offset(context.editor.selection.offset)
    line_offset = context.editor.styled_text.offset_at_line(line)
    
    context.editor.selection = [line_offset, context.editor.document.length - line_offset]
    # context.editor.selection.move_to.beginning_of_line
    # context.editor.selection.extend_to.end_of_document

    # escape chars that are special in snippets
    text = context.editor.selection.text.gsub('[\$\`\\]', '\\\\\1')

    if @@snippets.has_key? snippet
      output = insert_migration(context, @@snippets[snippet], text)
    else
      # return the unmodified text
      output = text
    end
    output
  end

end
