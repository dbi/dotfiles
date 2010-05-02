desc "Check the JavaScript source with JSLint - exit with status 1 if any of the files fail."
task :jslint do
  jsl_path = "jsl" # get jsl bin from http://javascriptlint.com
  failed_files = []

  Dir['public/**/*.js'].reject{|path| path =~ /javascripts.js/ }.each do |fname|
    cmd = "#{jsl_path} -nologo -nocontext -nofilelisting -process #{fname} | grep err"
    results = %x{#{cmd}}
    puts "#{fname} | " << results
    results.gsub("(s)","").split(",").each do |result|
      result = result.split(" ")
    
      if result[0].to_i > 0 and result[1] =~ /error/
        failed_files << fname
      end
    end
  end
  puts "="*80
  if failed_files.size > 0
    failed_files.each { |file| puts "[ERROR] " << file }
    exit 1
  else
    puts "No problems"
  end
end
