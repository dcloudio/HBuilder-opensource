require 'ruble'

bundle do |bundle|
  bundle.author = 'Bob Aman, Christopher Williams'
  bundle.copyright = "Copyright 2010 Aptana Inc. Distributed under the MIT license."
  bundle.display_name = t(:bundle_name)
  bundle.description = "Port of Bob Aman's TextMate Bundle for Sass, a template language for easily creating CSS; implemented in ruby."
  bundle.repository = 'http://github.com/aptana/sass.ruble.git'
  
  # Folding
  folding_start_marker = /^\s*([-%#\:\.\w\=].*)\s$/
  folding_stop_marker = /^\s*$/
  bundle.folding['source.sass'] = folding_start_marker, folding_stop_marker
  
  # Auto-indent, stolen from CSS ruble
  indent_marker = /\/\*\*(?!\*)|\{\s*($|\/\*(?!.*?\*\/.*\S))/
  dedent_marker = /\*\*\/|^\s*\}/
  bundle.indent['source.sass'] = [indent_marker, dedent_marker]
  
  # Associate *.sass with a top-level scope of source.sass
  bundle.file_types['source.sass'] = '*.sass', '*.less'
  
  bundle.menu t(:bundle_name) do |main_menu|
    main_menu.scope = ['source.sass', 'source.css']
    
    main_menu.menu t(:background) do |submenu|
      submenu.command 'background: color image repeat attachment position copy'
      submenu.separator
      submenu.command 'background-color: rgb'
      submenu.command 'background-color: rgba'
      submenu.command 'background-color: name'
      submenu.command 'background-color: transparent'
      submenu.separator
      submenu.command 'background-image: url'
      submenu.command 'background-image: none'
      submenu.separator
      submenu.command 'background-attachment: scroll/fixed'
      submenu.command 'background-position: position'
      submenu.command 'background-repeat: r/r-x/r-y/n-r'
    end
    main_menu.menu t(:border) do |submenu|
      submenu.command 'border: size style color copy'
      submenu.command 'border-top: size style color'
      submenu.command 'border-right: size style color'
      submenu.command 'border-bottom: size style color'
      submenu.command 'border-left: size style color'
      submenu.separator
      submenu.command 'border-width: size'
      submenu.command 'border-top-width: size'
      submenu.command 'border-right-width: size'
      submenu.command 'border-bottom-width: size'
      submenu.command 'border-left-width: size'
      submenu.separator
      submenu.command 'border-style: style'
      submenu.command 'border-top-style: style'
      submenu.command 'border-right-style: style'
      submenu.command 'border-bottom-style: style'
      submenu.command 'border-left-style: style'
      submenu.separator
      submenu.command 'border-color: color'
      submenu.command 'border-top-color: color'
      submenu.command 'border-right-color: color'
      submenu.command 'border-bottom-color: color'
      submenu.command 'border-left-color: color'
      submenu.separator
      submenu.command 'border-radius:'
    end
    main_menu.menu t(:cursor) do |submenu|
      submenu.command 'cursor: type'
      submenu.command 'cursor: url'
    end
    main_menu.menu t(:color) do |submenu|
      submenu.command 'color: hex'
      submenu.command 'color: rgb'
      submenu.command 'color: name'
    end
    main_menu.menu t(:display) do |submenu|
      submenu.command 'display: inline'
      submenu.command 'display: block'
      submenu.command 'display: common-types'
      submenu.command 'display: table-types'
    end
    main_menu.menu t(:font) do |submenu|
      submenu.command 'font: size font'
      submenu.command 'font: style variant weight size/line-height font-family'
      submenu.separator
      submenu.command 'font-family: family'
      submenu.command 'font-size: size'
      submenu.command 'font-style: normal/italic/oblique'
      submenu.command 'font-variant: normal/small-caps'
      submenu.command 'font-weight: weight'
    end
    main_menu.menu t(:list_style) do |submenu|
      submenu.command 'list-style: type position image'
      submenu.command 'list-style-image: url'
      submenu.command 'list-style-position: pos'
      submenu.separator
      submenu.command 'list-style-type: marker'
      submenu.command 'list-style-type: numeric'
      submenu.command 'list-style-type: roman-alpha-greek'
      submenu.command 'list-style-type: asian'
      submenu.command 'list-style-type: other'
    end
    main_menu.menu t(:margin) do |submenu|
      submenu.command 'margin: T R B L'
      submenu.command 'margin: all'
      submenu.command 'margin: V H'
      submenu.separator
      submenu.command 'margin-top: length'
      submenu.command 'margin-right: length'
      submenu.command 'margin-bottom: length'
      submenu.command 'margin-left: length'
    end
    main_menu.menu t(:padding) do |submenu|
      submenu.command 'padding: T R B L'
      submenu.command 'padding: all'
      submenu.command 'padding: V H'
      submenu.separator
      submenu.command 'padding-top: length'
      submenu.command 'padding-right: length'
      submenu.command 'padding-bottom: length'
      submenu.command 'padding-left: length'
    end
    main_menu.menu t(:text) do |submenu|
      submenu.command 'text-align: left/center/right'
      submenu.command 'text-decoration: none/underline/overline/line-through/blink'
      submenu.command 'text-indent: length'
      submenu.separator
      submenu.command 'text-shadow: color-hex x y blur'
      submenu.command 'text-shadow: color-rgb x y blur'
      submenu.command 'text-shadow: none'
      submenu.separator
      submenu.command 'text-transform: capitalize/upper/lower'
      submenu.command 'text-transform: none'
    end
    main_menu.separator
    main_menu.menu t(:other) do |submenu|
      submenu.command t(:attribute_selector)
      submenu.command 'background-color: hex'
      submenu.command 'box-shadow:'
      submenu.command 'clear: value'
      submenu.command 'direction: ltr/rtl'
      submenu.command 'float: left/right/none'
      submenu.command 'letter-spacing: em'
      submenu.command 'letter-spacing: px'
      submenu.command 'marker-offset: length'
      submenu.command 'marker-offset: auto'
      submenu.command 'overflow: type'
      submenu.command 'position: type'
      submenu.command 'vertical-align: type'
      submenu.command 'visibility: type'
      submenu.command 'white-space: normal/pre/nowrap'
      submenu.command 'word-spacing: length'
      submenu.command 'word-spacing: normal'
      submenu.command 'z-index: index'
    end
    main_menu.command t(:compile_sass)
    main_menu.command t(:convert_css_to_sass)
    main_menu.command t(:insert_color)
  end
end

# add special ENV vars
env "source.sass" do |e|
  # Single line comments
  e['TM_COMMENT_START'] = "// "
  e.delete('TM_COMMENT_END')
  
  # Block comments
  e['TM_COMMENT_START_2'] = "/* "
  e['TM_COMMENT_END_2'] = " */"
  
  # Remove any possible 3rd comment type...
  e.delete('TM_COMMENT_START_3')
  e.delete('TM_COMMENT_END_3')
end