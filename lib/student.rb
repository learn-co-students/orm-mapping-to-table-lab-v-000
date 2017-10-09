require 'pry'

class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end


  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT)"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE students"
    DB[:conn].execute(sql)
  end

  def self.create(name:, grade:)
    new_student = self.new(name, grade)
    new_student.save
    new_student
  end

  def save
    sql = "INSERT INTO students(name, grade) VALUES (?, ?)"
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT id FROM students ORDER BY id DESC LIMIT 1").flatten.first
  end
end
