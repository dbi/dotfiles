require "rubygems"
require "pp"

def history
    puts Readline::HISTORY.entries.join("\n").split("\nexit\n").last.split("\n")[1..-2]
end

def quick(repetitions=100, &block)
  require 'benchmark'
  Benchmark.bmbm do |b|
    b.report {repetitions.times &block} 
  end
  nil
end

def copy(data)
  File.popen('pbcopy', 'w') { |p| p << data.to_s }
  $?.success?
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

# Faster inline documentation
# Usage: variable.ri_[TAB]
# Or:    r 'String#str[TAB]'
# http://eigenclass.org/hiki.rb?cmd=view&p=irb+ri+completion&key=ruby%2Bdocumentation%2Birb
begin
  raise LoadError.new("Fast-RI not found, gem install fastri") unless system("which fri")
  require 'irb/completion'
  RI_EXECUTABLE = "qri" # "fri" is faster but must start a server with "fastri-server"

  module Kernel
    def r(arg)
      puts `#{RI_EXECUTABLE} "#{arg}"`
    end
    private :r
  end

  class Object
    def puts_ri_documentation_for(obj, meth)
      case self
      when Module
        candidates = ancestors.map{|klass| "#{klass}::#{meth}"}
        candidates.concat(class << self; ancestors end.map{|k| "#{k}##{meth}"})
      else
        candidates = self.class.ancestors.map{|klass|  "#{klass}##{meth}"}
      end
      candidates.each do |candidate|
        desc = `#{RI_EXECUTABLE} '#{candidate}'`
        unless desc.chomp == "nil"
          puts desc
          return true
        end
      end
      false
    end
    private :puts_ri_documentation_for

    def method_missing(meth, *args, &block)
      if md = /ri_(.*)/.match(meth.to_s)
        unless puts_ri_documentation_for(self,md[1])
          "Ri doesn't know about ##{meth}"
        end
      else
        super
      end
    end

    def ri_(meth)
      unless puts_ri_documentation_for(self,meth.to_s)
        "Ri doesn't know about ##{meth}"
      end
    end
  end

  RICompletionProc = proc{|input|
    bind = IRB.conf[:MAIN_CONTEXT].workspace.binding
    case input
    when /(\s*(.*)\.ri_)(.*)/
      pre = $1
      receiver = $2
      meth = $3 ? /\A#{Regexp.quote($3)}/ : /./ #}
      begin
        candidates = eval("#{receiver}.methods", bind).map do |m|
          case m
          when /[A-Za-z_]/; m
          else # needs escaping
            %{"#{m}"}
          end
        end
        candidates = candidates.grep(meth)
        candidates.map{|s| pre + s }
      rescue Exception
        candidates = []
      end
    when /([A-Z]\w+)#(\w*)/ #}
      klass = $1
      meth = $2 ? /\A#{Regexp.quote($2)}/ : /./
      candidates = eval("#{klass}.instance_methods(false)", bind)
      candidates = candidates.grep(meth)
      candidates.map{|s| "'" + klass + '#' + s + "'"}
    else
      IRB::InputCompletor::CompletionProc.call(input)
    end
  }
  Readline.basic_word_break_characters= " \t\n\\><=;|&"
  Readline.completion_proc = RICompletionProc
rescue LoadError => err
  warn "Couldn't load RI comletion: #{err}"
end

# All scripts loaded
puts "loaded: ~/.irbrc"
