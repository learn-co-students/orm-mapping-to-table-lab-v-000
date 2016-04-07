require 'pry'

class Student
  attr_accessor :name, :grade
  attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  def initialize(id = nil, name, grade)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER);
    SQL
    results = DB[:conn].execute(sql) #I had this preparing, then executing the sql, but I believe
    # that's overkill when it's a prepared statement alright, correct?
  end

  def self.drop_table
    sql = "DROP TABLE students;"
    results = DB[:conn].execute(sql)
  end

  def save
    sql = DB[:conn].prepare("INSERT INTO students (name, grade) VALUES (?, ?)")
    sql.execute(self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0] unless @id != nil
  end

  def self.create(student_hash)
    student = Student.new(student_hash[:name], student_hash[:grade])
    student.save
    student
  end
end
