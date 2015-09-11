require 'ruble'

command t(:docs_for_tag) do |cmd|
  #cmd.key_binding = 'M4+H'
  cmd.scope = 'comment.block.documentation.phpdoc.php'
  cmd.output = :show_as_html
  cmd.input = :selection, :word
  cmd.invoke do |context|
    word = STDIN.read
    if word.match(/[@a-zA-Z]+/)
      word = word.gsub(/@/,"")
      # This is a hack to open the internal browser and point it to the php.net page.
      "<meta http-equiv='Refresh' content='0;URL=http://manual.phpdoc.org/HTMLframesConverter/earthli/phpDocumentor/tutorial_tags.#{word}.pkg.html'>"
    end
  end
end
