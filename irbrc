require "rubygems"
require "pp"

def quick(repetitions=100, &block)
  require 'benchmark'
  Benchmark.bmbm do |b|
    b.report {repetitions.times &block} 
  end
  nil
end

# Autocomplete, coloring and more.
# http://pablotron.org/software/wirble/
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

# Nicer active record ouput. http://tagaholic.me/hirb/
begin
  require "hirb"
  Hirb.enable
rescue LoadError => err
  warn "Couldn't load Hirb: #{err}"
end

# Method lookup
# Usage: lp variable
# http://github.com/oggy/looksee
begin
  require 'looksee/shortcuts'
rescue LoadError => err
  warn "Couldn't load Looksee: #{err}"
end

# from: http://github.com/ryanb/dotfiles/
class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
  
  # print documentation
  #
  #   ri 'Array#pop'
  #   Array.ri
  #   Array.ri :pop
  #   arr.ri :pop
  def ri(method = nil)
    unless method && method =~ /^[A-Z]/ # if class isn't specified
      klass = self.kind_of?(Class) ? name : self.class.name
      method = [klass, method].compact.join('#')
    end
    cmd = system("which fri") ? "fri" : "ri"
    puts `#{cmd} '#{method}'`
  end
end
warn "Fast-RI not found (gem install fastri)" unless system("which fri")

def copy(str)
  IO.popen('pbcopy', 'w') { |f| f << str.to_s }
end

def copy_history
  history = Readline::HISTORY.entries
  index = history.rindex("exit") || -1
  content = history[(index+1)..-2].join("\n")
  puts content
  copy content
end

def paste
  `pbpaste`
end

load File.dirname(__FILE__) + '/.railsrc' if $0 == 'irb' && ENV['RAILS_ENV']
