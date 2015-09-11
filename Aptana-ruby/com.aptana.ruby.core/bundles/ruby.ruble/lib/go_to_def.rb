# A class which takes in a src file and an offset and then tries to determine what lives position and trace it back to it's declaration.
class GoToDefinition

  def initialize(io, caret_offset)
    @io = io
    @offset = caret_offset - 1 # Move back one char...
  end

  def run
    src = @io.read
    resolve_context = com.aptana.ruby.core.codeassist.ResolveContext.new(java.io.File.new(ENV['TM_FILEPATH']).toURI, src, @offset)
    resolver = com.aptana.ruby.core.RubyCorePlugin.getDefault.getCodeResolver
    resolver.resolve(resolve_context)
    targets = resolve_context.getResolved
    Ruble::Logger.trace targets
    
    # We're done tracing back to possible declarations, pick the one to open
    location = nil
    if targets.size == 1 # There is only one, so use it
      location = targets[0]
    else
      # FIXME Prioritize the entries. For example, if I'm resolving ActionControl::Base, prefer a path ending in 'actioncontroller/base.rb'
      # Pop up a menu UI if there's more than one location so user chooses the one they want
      require 'ruble/ui'
      index = Ruble::UI.menu(targets.map {|l| "#{l.getURI.to_s}, range: #{l.getRange.to_s}" }) # TODO Display positions, trim file to relative path from index root or maybe display the enclosing type or something instead
      location = targets[index] if index
    end
    # Now open the editor to the file/line of the declaration chosen
    open(location) if location
  end
  
  def open(location)
    require 'ruble/editor'
    editor = Ruble::Editor.go_to(:file => location.getURI.to_s)
    editor.selection = [location.range.starting_offset, location.range.length] if editor
    editor
  end
  
end