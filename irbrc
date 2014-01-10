require "rubygems"

puts "#{RUBY_VERSION} p#{RUBY_PATCHLEVEL} (#{RUBY_RELEASE_DATE}) #{RUBY_PLATFORM}"
IRB.conf[:PROMPT_MODE] = :DEFAULT

# Quick and dirty benchmarking
#
#   quick(10) { sleep 0.1 }
def quick(repetitions=100, &block)
  require 'benchmark'
  Benchmark.bmbm do |b|
    b.report {repetitions.times &block}
  end
  nil
end

# Time command execution
#
#   time { sleep 1 }
def measure_time
  start = Time.now
  result = yield
  puts sprintf "Total: %.2fs", Time.now - start
  result
end

# Method lookup http://github.com/oggy/looksee
#
#   lp variable
begin
  require 'looksee'
rescue LoadError => err
  warn "Couldn't load Looksee: #{err}"
end

# Copy string to clipboard
#
#   copy "hello"
def copy(str)
  IO.popen('pbcopy', 'w') { |f| f << str.to_s }
end


# Copy irb history to clipboard
#
#   copy_history
def copy_history
  history = Readline::HISTORY.entries
  index = history.rindex("exit") || -1
  content = history[(index+1)..-2].join("\n")
  puts content
  copy content
end

# Paste clipboard as string
#
#   x = paste
def paste
  `pbpaste`
end

# Automatically load .railsrc
load File.dirname(__FILE__) + '/.railsrc' if $0 == 'irb' && ENV['RAILS_ENV']
