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

require_rel "is_a/"

module IsA

  def self.reset
    IsA::Category.delete_all
    IsA::Characteristic.delete_all
  end

end
