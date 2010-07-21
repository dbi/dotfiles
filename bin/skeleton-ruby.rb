#!/usr/bin/env ruby

system "mkdir lib"
puts "      create lib"

system "mkdir spec"
puts "      create spec"

File.open("spec/helper.rb", 'w') {|f|
  f.write(%{
$: << File.join(File.dirname(__FILE__), '..', 'lib')

require "spec"
require 'mocha'

Spec::Runner.configure do |config|
  config.mock_with :mocha
end
}.lstrip)
}
puts "      create spec/helper.rb"

File.open("spec/spec.opts", 'w') {|f|
  f.write(%{
--colour
--loadby mtime
--require spec/helper.rb
}.lstrip)
}
puts "      create spec/spec.opts"

File.open("spec/first_spec.rb", 'w') {|f|
  f.write(%{
describe "First test" do

  it "should run" do
    true.should be_true
  end

end
}.lstrip)
}
puts "      create spec/first_spec.rb"
