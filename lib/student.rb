require 'pry'

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade #student attribute has name and grade
  attr_reader :id #has id that is readable but not writable

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table #creates student table in database
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      );
      SQL

      DB[:conn].execute(sql)
  end

  def self.drop_table #drops the student table from the database
    sql = <<-SQL
    DROP TABLE students
    SQL

    DB[:conn].execute(sql)
  end

  def save #saves an instance of the Student CLASS TO the database
    sql = <<-SQL
      INSERT INTO students(name, grade)
      VALUES (?,?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:) #new student object , saves
    student = Student.new(name, grade)
    student.save
    student #return 
  end

end
