module BugHelper

  def bug
    case type
      when 1
        # whatever
      when 2 
        # whatever 2
        Bug.find_by_sql(<<-SQL
          you think this #{may} bug bug BUG
          bug
          bug
          bug
        SQL
        )
        ##{bug bug bug}
      else 
        # adfsaf bugbug bug
        if bug2
          select_sql = ", #{owner.id} AS bug_id"
          # If this bug
          if bug
            condition_sql = "AND c.bug='#{bug.class.name}' AND c.bug='#{bug.id}'"
            #bugbgugbug
            a = 2
          end
        end
        Bug.find_by_sql(<<-SQL
          BUg2
            BUg2       
          WHERE c.discussable_type='#{bug.class.name}' AND c.bug=#{bug.id} #{bug}
          ORDER BY c.bug DESC 
        SQL
        )
        #bug.find(:all, :order =>)  
    end
  end
  
  def bug2
    @abc = "/bug#{'/bug2' if @bug}"
    @bug = "What's bug?"
  end
  
  def bug3
    @show_bug = true
    
    # only for bug! TOTHINK: worth the trouble here? ... but it slows down
    @buggy_keys = [1] if buggy
    if @bug.item then @buggy_keys = @bugs ? @ buggy.push(a, 2) : [3 , 4] end
    # p @buggy_keys; p @bugs; p @buggs
    # NOTE! we don't need to check for bugs in _bugs.html.erb
    # bugs_key = 4 AND body LIKE '%>#{BUGS[3][:key]}<%'
  end

end