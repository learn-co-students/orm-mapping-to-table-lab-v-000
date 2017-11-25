
require 'pry'
class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    table = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )
    SQL
    DB[:conn].execute(table)

  end

  def self.drop_table
    table = <<-SQL
      DROP TABLE IF EXISTS students
      SQL
      DB[:conn].execute(table)
  end

  def save
    table = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?,?)
    SQL

    DB[:conn].execute(table, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    student = Student.new(name,grade)
    student.save
    student
  end

end
