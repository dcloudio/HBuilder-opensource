module Rails
  class ContentAssistant
    
    IRubyIndexConstants = com.aptana.ruby.core.index.IRubyIndexConstants
    # CoreStubber = com.aptana.ruby.internal.core.index.CoreStubber
    SearchPattern = com.aptana.index.core.SearchPattern
    IndexManager = com.aptana.index.core.IndexManager
    RubyLaunchingPlugin = com.aptana.ruby.launching.RubyLaunchingPlugin
  
    def initialize(io, offset)
      @src = io.read
      @offset = offset
    end
    
    def assist
      suggestions = []
      # TODO Include "location" where each suggestion was found?
      image = "platform:/plugin/com.aptana.ruby.ui/icons/full/obj16/instance_var_obj.png"
      location = ''
      # Handle instance variables in eRB
      if prefix.start_with? "@"
        dir_name = filepath.removeLastSegments(1).lastSegment
        location = "#{dir_name}_controller.rb"
        # TODO make location more specific? method defined in?
        results = index.query([IRubyIndexConstants::FIELD_DECL], prefix, SearchPattern::PREFIX_MATCH | SearchPattern::CASE_SENSITIVE)
        results.each {|r| suggestions << r.word.split('/').first if !r.documents.select {|d| d.end_with? "#{dir_name}_controller.rb" }.empty? } if results # TODO Limit to only words found in the matching controller!
      else
        # Handle helper methods in eRB
        image = "platform:/plugin/com.aptana.ruby.ui/icons/full/obj16/class_method.png"
        # Now we look for all methods matching the prefix and then post-filter to only those defined in the helper's files.
        gem_and_project_indices.each do |index|
          results = index.query([IRubyIndexConstants::METHOD_DECL], "^#{prefix}[^/]*/\\w+?Helper/.+$", SearchPattern::REGEX_MATCH | SearchPattern::CASE_SENSITIVE)
          (results || []).each do |r|
            # TODO include Helper type name as "location"
            r.getDocuments.each {|d| suggestions << r.word.split('/').first }
          end
        end
      end
      # Flatten and keep only uniques
      suggestions.flatten!
      suggestions.uniq!
      # Elininate nil
      suggestions = suggestions.select {|s| s }
      # Sort by display name
      suggestions.sort!
      # Turn into hash so we can supply image
      suggestions = suggestions.map {|s| {:insert => s, :image => image } }
      Ruble::Logger.trace "Rails content assist suggestions: #{suggestions.inspect}"
      suggestions.inspect
    end
    
    private
    def parser
      @parser ||= org.jrubyparser.Parser.new
    end
    
    def parser_config
      org.jrubyparser.parser.ParserConfiguration.new(0, org.jrubyparser.CompatVersion::BOTH)
    end
    
    def get_children_recursive(parent, type)
      children = parent.getChildrenOfType(type) 
      partial = []
      children.each {|c| partial << c; partial << get_children_recursive(c, type) }
      partial.flatten!
      partial
    end
    
    def filepath
      org.eclipse.core.runtime.Path.new(ENV['TM_FILEPATH'])
    end
    
    def gem_and_project_indices
      gem_indices << index
    end
    
    def gem_indices
      gem_paths = RubyLaunchingPlugin.getGemPaths(project)
      gem_paths.collect {|g| index_manager.getIndex(g.toFile.toURI) }.compact
    end
    
    def index
      index_manager.getIndex(project.locationURI)
    end
    
    def index_manager
      IndexManager.getInstance
    end
    
    def project
      file = org.eclipse.core.resources.ResourcesPlugin.workspace.root.getFileForLocation(filepath)
      return file.project
    end
    
    def offset
      @offset
    end
    
    def prefix
      return @prefix if @prefix
      @prefix = @src[0...offset + 1]
  
      # find last period/space/:
      index = @prefix.rindex('.')
      @prefix = @prefix[(index + 1)..-1] if !index.nil?
  
      index = @prefix.rindex(':')
      @prefix = @prefix[(index + 1)..-1] if !index.nil?
  
      index = @prefix.rindex(' ')
      @prefix = @prefix[(index + 1)..-1] if !index.nil?
  
      return @prefix
    end
    
    def full_prefix
      return @full_prefix if @full_prefix
      @full_prefix = @src[0...offset + 1]
  
      # find last space/newline
      index = @full_prefix.rindex(' ')
      @full_prefix = @full_prefix[(index + 1)..-1] if !index.nil?
      
      index = @full_prefix.rindex('\n')
      @full_prefix = @full_prefix[(index + 1)..-1] if !index.nil?
      
      index = @full_prefix.rindex('\r')
      @full_prefix = @full_prefix[(index + 1)..-1] if !index.nil?
      
      index = @full_prefix.rindex('\t')
      @full_prefix = @full_prefix[(index + 1)..-1] if !index.nil?
  
      return @full_prefix
    end
  end
end