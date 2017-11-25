require 'pry'

class Student
  attr_accessor :name, :grade
  attr_reader :id

  #instantiate
  def initialize (name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  #creates students table
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

  #delete students table
  def self.drop_table
    sql = <<-SQL
        DROP TABLE IF EXISTS students
      SQL

    DB[:conn].execute(sql)
  end

  #save student data
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
      SQL

      DB[:conn].execute(sql, @name, @grade)

      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  #create new instance and then save a record of it in database
  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end


end
