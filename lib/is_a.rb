require 'rubygems'
require 'bundler'
require 'bundler/setup'
require 'dotenv'
require 'mongoid'
require 'require_all'
require 'pry'

Dotenv.load
Bundler.require
Mongoid.load!("config/mongoid.yml")

require_all "lib/is_a"

module IsA
  # Your code goes here...
end
