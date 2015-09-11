require 'ruble'

content_assist 'ERb Content Assist' do |ca|
  ca.scope = 'source.ruby.rails.embedded.html'
  ca.invoke do |context|
    require 'content_assistant'
    Rails::ContentAssistant.new($stdin, context.editor.caret_offset - 1).assist
  end
end

