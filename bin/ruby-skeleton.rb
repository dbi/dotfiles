#!/usr/bin/env ruby

system "mkdir lib"
system "mkdir spec"

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

File.open("spec/spec.opts", 'w') {|f|
  f.write(%{
--colour
--loadby mtime
--require spec/helper.rb
}.lstrip)
}

File.open("spec/first.spec", 'w') {|f|
  f.write(%{
describe "First test" do

  it "should run" do
    true.should be_true
  end

end
}.lstrip)
}