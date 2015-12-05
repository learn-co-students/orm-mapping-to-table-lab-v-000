require 'pry'
require_relative "../config/environment.rb"

class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name,grade,id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-sql
      CREATE TABLE IF NOT EXISTS students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )
    sql
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-sql
      DROP TAble students
    sql
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-sql
      INSERT INTO students (name,grade)
      VALUES (?,?)
    sql
    DB[:conn].execute(sql,name,grade)
  end

  def self.create(name:,grade:)
    student = Student.new(name,grade)
    student.save
    student
  end
end
