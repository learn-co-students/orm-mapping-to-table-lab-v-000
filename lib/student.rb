require 'pry'
require_relative "../config/environment.rb"

class Student
  attr_accessor :name, :grade
  attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def initialize (name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  #creates the students table in the database
  def self.create_table
    sql = <<-SQL 
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
      )
    SQL
    
    DB[:conn].execute(sql)
  end

  #drops the students table from the database
  def self.drop_table
    sql = <<-SQL 
    DROP TABLE students
    SQL

    DB[:conn].execute(sql)
  end

  #saves an instance of the Student class to the database
  def save
    sql = <<-SQL 
    INSERT INTO students (name, grade) 
    VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0] #gets the id from the database
  end

  #takes in a hash of attributes and uses metaprogramming to create a new student object. Then it uses the #save method to save that student to the database
  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save
    student #returns the new object that it instantiated
  end

end
