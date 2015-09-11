with_defaults :scope => 'text.haml' do

  # Filters
  with_defaults :trigger => 'filter' do
    snippet t(:cdata) do |s|
      s.expansion = ':cdata
  $0'
    end
    
    snippet t(:erb) do |s|
      s.expansion = ':erb
  $0'
    end
    
    snippet t(:escaped) do |s|
      s.expansion = ':escaped
  $0'
    end
    
    snippet t(:javascript) do |s|
      s.expansion = ':javascript
  $0'
    end
    
    snippet t(:markdown) do |s|
      s.expansion = ':markdown
  $0'
    end
    
    snippet t(:maruku) do |s|
      s.expansion = ':maruku
  $0'
    end
    
    snippet t(:preserve) do |s|
      s.expansion = ':preserve
  $0'
    end
    
    snippet t(:ruby) do |s|
      s.expansion = ':ruby
  $0'
    end
    
    snippet t(:sass) do |s|
      s.expansion = ':sass
  $0'
    end
    
    snippet t(:textile) do |s|
      s.expansion = ':textile
  $0'
    end
    
    snippet t(:plain) do |s|
      s.expansion = ':plain
  $0'
    end
  end

  # META
  with_defaults :trigger => 'meta' do
    snippet t(:meta_http_equiv) do |s|
      s.trigger = 'meta'
      s.expansion = '%meta{ \'http-equiv\' => \'Content-Type\', :content => \'text/html;\', \'charset\' => \'utf-8\'${1:, }$2 }$0'
    end
    
    snippet t(:meta_generic) do |s|
      s.trigger = 'meta'
      s.expansion = '%meta{ :name => \'$1\', :content => \'$2\'${3:, }$4 }$0'
    end
  end

  # Doctypes
  with_defaults :trigger => 'doctype' do
    snippet t(:xhtml_1_strict) do |s|
      s.expansion = '!!! strict'
    end
    
    snippet t(:xhtml_1_transitional) do |s|
      s.expansion = '!!!'
    end
    
    snippet t(:xhtml_1_1) do |s|
      s.expansion = '!!! 1.1'
    end
    
    snippet t(:xhtml_mobile) do |s|
      s.expansion = '!!! Mobile'
    end
  end
  
  # XML
  with_defaults :trigger => 'xml' do
    snippet t(:xml_prolog_iso_8859_1) do |s|
      s.expansion = '!!! XML iso-8859-1'
    end
    
    snippet t(:xml_prolog) do |s|
      s.expansion = '!!! XML'
    end
  end
  
  # Miscellaneous
  
  snippet t(:insert_tag) do |s|
    #s.key_binding = 'CONTROL+M2+,'
    s.expansion = '%${1:p}'
  end
  
  snippet t(:html_en_us) do |s|
    s.trigger = 'html'
    s.expansion = '%html{ :xmlns => "http://www.w3.org/1999/xhtml", :lang => "en", \'xml:lang\' => "en" }'
  end
  
  snippet t(:ie_conditional) do |s|
    s.trigger = 'ie'
    s.expansion = '/[if ${1:lte }IE${3: ${2:version}}]
  $0'
  end
  
  snippet t(:page_class) do |s|
    s.trigger = 'pc'
    s.expansion = 'page_class'
  end
  
  snippet t(:element_attribute) do |s|
    s.trigger = ':'
    s.expansion = ':${1:AttributeName} => "$2"${3:, }$0'
  end
end