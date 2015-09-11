require 'ruble'
require 'ruble/ui'

def ri(term, recurse = true)
  # TODO this won't work for windows
  ri_exe = "ri"
  documentation = `#{ri_exe} '#{term}' 2>&1` \
                  rescue "<h1>ri Command Error.</h1>"
  if documentation =~ /\ACouldn't open the index/
    return 
      "Index needed by #{ri_exe} not found.\n" +
      "You may need to run:\n\n"               +
      "  fastri-server -b"
  elsif documentation =~ /\ACouldn't initialize DRb and locate the Ring server./
    return "Your fastri-server is not running."
  elsif documentation =~ /Nothing known about /
    return documentation
  elsif documentation.sub!(/\A>>\s*/, "")
    return "Unable to determine unambiguous name" if !recurse
    choices = documentation.split
    choice  = Ruble::UI.menu(choices)
    return nil if choice.nil?
    ri(choices[choice], false)
  elsif documentation =~ /\AMore than one method matched your request/
    return "Unable to determine unambiguous name" if !recurse
    choices = documentation.split(',')
    choices.delete_at(0)
    choices = choices.collect {|w| w.strip }
    choices = choices.select {|w| w.strip.length > 0 }
    choices.uniq!
    choice  = Ruble::UI.menu(choices)
    return nil if choice.nil?
    ri(choices[choice], false)
  else  
    return documentation
  end
end

command t(:doc_for_word) do |cmd|
  #cmd.key_binding = 'M4+H'
  cmd.output = :show_as_tooltip
  cmd.input = :selection, :word
  cmd.scope = "source.ruby", "source.ruby.rails"
  cmd.invoke do |context|
   term = STDIN.read.strip
   if term.empty?
     "Please select a term to look up."
   else
     ri(term)
   end
  end
end
