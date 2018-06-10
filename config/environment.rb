require 'bundler' #requies the undler gem
Bundler.require #uses bundler to pull in all other gems

require_relative '../lib/student' #requires the student class from lib

DB = {:conn => SQLite3::Database.new("db/students.db")} #initializes a database connection
