require 'ruble'

command t(:post_doc) do |cmd|
  cmd.scope = 'source.php'
  cmd.trigger = 'doc'
  cmd.output = :insert_as_snippet
  cmd.input = :document
  cmd.invoke do
    next_line = STDIN.read.to_a[ENV['TM_LINE_NUMBER'].to_i..-1].join("\n").strip[/.+$/]
    
    puts '/**'
    
    @tags = []
    elementType = ''
    author = true
    
    def tag(tag, default, trailing = nil)
      @tags << {:tag => tag, :default => default, :trailing => trailing}
    end
    
    case next_line
      when /(class|interface)/
        elementType = $&
        tag 'package', 'default'
      when /function\s*(\w+)\((.*)\)/
        function_name, args = $1, $2
        elementType = 'function'
        args.split(/,/).each do |arg|
          arg.strip =~ /(?:(\w+)\s*)?\$([A-z0-9]+)/
          tag 'param', $1 || 'string', "\\$" + $2
        end
        tag 'return', 'void' unless function_name == '__construct'
      when /const|define/
        elementType = 'constant'
        author = false
      when /var|p(ublic|rivate|rotected)\s*\$/
        elementType = 'variable'
        tag 'var', 'string'
        author = false
    end
    
    puts " * ${1:undocumented " + elementType
    puts ' *' if @tags.size > 0 or author
    
    placeholder = 1
    @tags.each do |mytag|
      placeholder += 1
      if mytag[:trailing]
        puts ' * @' + mytag[:tag].to_s + " ${" + placeholder.to_s + ":" + mytag[:default].to_s + "} " + mytag[:trailing].to_s + " \$" + (placeholder += 1).to_s
      else
        puts ' * @' + mytag[:tag].to_s + " ${" + placeholder.to_s + ":" + mytag[:default].to_s + "}"
      end
    end
    
    puts " * @author #{ENV['TM_FULLNAME']}" if author
    print ' */$0'
    nil
  end
end