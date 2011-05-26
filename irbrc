require "rubygems"

puts "#{RUBY_VERSION} p#{RUBY_PATCHLEVEL} (#{RUBY_RELEASE_DATE}) #{RUBY_PLATFORM}"
IRB.conf[:PROMPT_MODE] = :DEFAULT

# Hack to load gems outside of bundler
#
# https://gist.github.com/794915
if defined?(::Bundler)
  $LOAD_PATH.concat Dir.glob("#{ENV['rvm_ruby_global_gems_path']}/gems/*/lib")
end

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
def time
  start = Time.now
  result = yield
  puts sprintf "Total: %.2fs", Time.now - start
  result
end

# Wirble https://github.com/blackwinter/wirble
begin
  require 'wirble'
  Wirble.init

  colors = Wirble::Colorize.colors.merge({
    :comma              => :light_gray,
    :refers             => :light_gray,

    :open_hash          => :light_gray,
    :close_hash         => :light_gray,
    :open_array         => :light_gray,
    :close_array        => :light_gray,

    :open_object        => :blue,
    :object_class       => :purple,
    :object_addr_prefix => :blue,
    :object_line_prefix => :blue,
    :close_object       => :blue,

    :symbol             => :yellow,
    :symbol_prefix      => :yellow,

    :open_string        => :dark_gray,
    :string             => :yellow,
    :close_string       => :dark_gray,

    :number             => :cyan,
    :keyword            => :green,
    :class              => :green,
    :range              => :red,
  })

  Wirble::Colorize.colors = colors
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end

# Method lookup http://github.com/oggy/looksee
#
#   lp variable
begin
  require 'looksee'
rescue LoadError => err
  warn "Couldn't load Looksee: #{err}"
end

# Interactive Editor https://github.com/jberkel/interactive_editor
#
#   vim
begin
  require 'interactive_editor'
rescue LoadError => err
  warn "Couldn't load interactive_editor: #{err}"
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
