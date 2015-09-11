require 'ruble'

bundle do |bundle|
  bundle.author = 'Christopher Williams'
  bundle.copyright = "Copyright 2010 Aptana Inc. Distributed under the MIT license."
  bundle.display_name =  t(:bundle_name)
  bundle.repository = "git://github.com/aptana/haml.ruble.git"
  bundle.description =  <<END
Ported from Matt Polito's HAML bundle for TextMate.

<a href="http://unspace.ca/discover/haml">HTML Abstraction Markup Language</a> is a templating engine for Ruby on Rails.
END
  # Folding
  start_folding = /^\s*([-%#\:\.\w\=].*)\s$/
  end_folding = /^\s*$/
  bundle.folding['text.haml'] = start_folding, end_folding

  bundle.menu t(:bundle_name) do |main_menu|
    main_menu.menu t(:insert_doctype) do |submenu|
      submenu.command t(:xhtml_1_strict)
      submenu.command t(:xhtml_1_transitional)
      submenu.command t(:xhtml_1_1)
      submenu.command t(:xhtml_mobile)
    end
    main_menu.menu t(:insert_xml_prolog) do |submenu|
      submenu.command t(:xml_prolog)
      submenu.command t(:xml_prolog_iso_8859_1)
    end
    main_menu.menu t(:filters) do |submenu|
      submenu.command t(:cdata)
      submenu.command t(:escaped)
      submenu.command t(:erb)
      submenu.command t(:javascript)
      submenu.command t(:markdown)
      submenu.command t(:maruku)
      submenu.command t(:plain)
      submenu.command t(:preserve)
      submenu.command t(:ruby)
      submenu.command t(:sass)
      submenu.command t(:textile)
    end
     main_menu.menu t(:meta_tags) do |submenu|
      submenu.command t(:meta_generic)
      submenu.command t(:meta_http_equiv)
    end
    main_menu.separator
    main_menu.command t(:html_en_us)
    main_menu.command t(:element_attribute)
    main_menu.command t(:ie_conditional)
    main_menu.command t(:page_class)
    main_menu.command t(:insert_tag)
    main_menu.command t(:convert_html_to_haml)
    main_menu.command t(:check_syntax)
  end
end

# Add special ENV vars
env "text.haml" do |e|
  e['TM_COMMENT_START'] = "-# "
  e.delete('TM_COMMENT_END')
  e['TM_COMMENT_START_2'] = "/"
  e.delete('TM_COMMENT_END_2')
  e.delete('TM_COMMENT_DISABLE_INDENT')
end