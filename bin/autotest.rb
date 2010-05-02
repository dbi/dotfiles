#!/usr/bin/env ruby

# kan förbättras med delar från projekten: rspactor & rerun
# men främst http://www.rubyinside.com/watchr-generic-autotest-alternativ-2511.html

# kolla watchr

# TODO: stacktraces can be alot better
# TODO: use fssm

require "rubygems"
require "spec"

module Output
  DEFAULT = "\033[0m"
  RED = "\033[31m"
  GREEN = "\033[32m"
  YELLOW = "\033[33m"
  
  class FakedTerminalStringIO < StringIO
    # To make StringIO accept colored output 
    def tty?() true end
  end
end

LOADING_MESSAGE = "#{Output::YELLOW}Running tests...#{Output::DEFAULT}"

def capture_stdout
  out = StringIO.new
  $stdout = out
  yield
  return out
ensure
  $stdout = STDOUT
end

def last_modified_file()
  Dir["{lib,spec}/**/*.{rb,spec,html}"].sort_by { |p| File.mtime(p) }.last
end

last_changed = Time.at(0)
begin
  loop do
    changed = File.mtime(last_modified_file)
    if changed > last_changed
      last_changed = changed
      
      puts "#{`clear`}\n#{LOADING_MESSAGE}"
      
      # alternative to `spec spec/*.spec --options spec/spec.opts`
      pid = fork do
      
        spec_result = Output::FakedTerminalStringIO.new
        arguments = Dir["spec/**/*.spec"].concat ["--options", "spec/spec.opts"]
        options = Spec::Runner::OptionParser.parse(arguments, $stderr, spec_result)
        spec_stdout = capture_stdout do
          Spec::Runner::CommandLine.run(options)
        end
        spec_result.close
      
        print `clear`
        puts spec_stdout.string
        puts spec_result.string
      end
      Process.wait(pid)
      
    end
    sleep 0.1
  end
rescue Interrupt
end
