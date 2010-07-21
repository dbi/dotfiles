#!/usr/bin/env ruby

system "skeleton-ruby.rb"

system "mkdir public"
puts "      create public"

system "mkdir views"
puts "      create views"

File.open("views/index.erb", 'w') {|f|
  f.write(%{
<!DOCTYPE HTML>
<html lang="sv">
  <head>
    <meta charset="utf-8">
    <title>Skeleton app</title>
  </head>
  <body>
    <h1>Skeleton</h1>
  </body>
</html>
}.lstrip)
}
puts "      create views/index.erb"

File.open("app.rb", 'w') {|f|
  f.write(%{
require 'rubygems'
require 'sinatra'

get '/' do
  erb :index
end
}.lstrip)
}
puts "      create app.rb"

File.open("config.ru", 'w') {|f|
  f.write(%{
require 'app'
run Sinatra::Application
}.lstrip)
}
puts "      create config.ru"
