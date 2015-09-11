require 'ruble'

command t(:wrap_docblock) do |cmd|
  cmd.scope = 'comment.block.documentation.phpdoc.php'
  cmd.output = :insert_as_text
  cmd.input = :none
  cmd.invoke do
    col = ENV['TM_COLUMN_NUMBER'].to_i
    start_col = ENV['TM_CURRENT_LINE'].index('*')
    if col - start_col >= 80
      puts
      print " " * start_col + "*"
    end
    print " "
  end
end
