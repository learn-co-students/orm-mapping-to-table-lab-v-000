require 'pry'
require_relative "../config/environment.rb"

class Student
  
  attr_accessor :name, :grade
  attr_reader :id
  
  def initialize(name = nil, grade = nil, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER)
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) VALUES (?,?)
    SQL
    DB[:conn].execute(sql,@name,@grade)
  end

  def self.create(attribute_hash)
    student = Student.new
    attribute_hash.each do |attribute,value|
      student.send("#{attribute}=",value)
    end
    student.save
    student
  end
end
