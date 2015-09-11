require 'ruble'

command t(:show_for_file) do |cmd|
  cmd.scope = 'source.ruby'
  cmd.output = :show_as_html
  cmd.input = :none
  cmd.invoke do |context|
    output = ENV['TM_FILENAME']
    input = output
    wd = ENV['TM_DIRECTORY']
    project_directory = ENV['TM_PROJECT_DIRECTORY']
    if File.directory?(project_directory)
      wd = project_directory
      output = `basename #{wd}`.strip # FIXME This probably doesn't work across systems!
      input = '.'
    end
    require 'tmpdir'
    output_dir = "#{Dir.tmpdir}/rdoc_#{output}"
    require 'fileutils'
    FileUtils.rm_rf output_dir    
    # OK now generate the RDoc
    Dir.chdir wd do 
      `rdoc -S -N -q -f html --op "#{output_dir}" "#{input}" &>/dev/null`
    end
    # And point to it
    "<html><head><meta http-equiv=\"refresh\" content=\"0;URL=file://#{output_dir}/index.html\"></head></html>"
  end
end
