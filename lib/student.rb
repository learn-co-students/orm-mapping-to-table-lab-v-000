class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def save
    # Insert name and grade into database
    sql_insert = <<-SQL 
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql_insert, self.name, self.grade)

    # Add ID from database to student instance
    sql_get_id = <<-SQL 
      SELECT last_insert_rowid() FROM students
    SQL

    @id = DB[:conn].execute(sql_get_id)[0][0]
  end

  def self.create(name:, grade:)
    new_student = Student.new(name,grade)
    new_student.save
    new_student
  end
  
  def self.create_table
    sql = <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL 
      DROP TABLE students
    SQL

    DB[:conn].execute(sql)
  end
  
end
