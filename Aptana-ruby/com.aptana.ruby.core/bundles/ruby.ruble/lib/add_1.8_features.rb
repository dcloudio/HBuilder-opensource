if RUBY_VERSION >= "1.9"
  class String
    def grep(*args)
      each_line.grep(*args)
    end                   
  
    def reject(&block)
      each_line.reject(&block)
    end 
  
    def map(&block)
      each_line.map(&block)
    end
  
    def inject(*args, &block)
      each_line.inject(*args, &block)
    end
  end
end