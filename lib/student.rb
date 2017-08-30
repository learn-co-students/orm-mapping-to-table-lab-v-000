require 'pry'

class Student
  attr_accessor :name, :grade
  attr_reader :id
 

  def initialize(id = nil, name, grade)
    @id = id 
    @name = name
    @grade = grade 
  end# if initialize 


  def self.create_table
    sql = <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
      ) 
      SQL

      DB[:conn].execute(sql)
  end# of self.create_table


  def self.drop_table
    sql = "DROP TABLE students;"
    DB[:conn].execute(sql)
  end# of self.drop_table


  def save
    sql = "INSERT INTO students (name, grade) VALUES (?,?)"
    DB[:conn].execute(sql, self.name, self.grade)
    student_id = DB[:conn].execute("SELECT last_insert_rowid() FROM students;")
    @id = student_id.flatten.join.to_f
  end# of self.save


  def self.create(name: name, grade: grade)
    student = Student.new(name, grade)
    student.save 
    student 
  end# of self.create

  


end
