class Student

    attr_accessor :name, :grade
    attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  #1. job is to build out the student class with attributes name and grade

    def initialize(name, grade, id = nil)
      @name = name
      @grade = grade
      @id = id
    end

  #2. also build a class method on the student class that creates the students table in the database

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

  #Method hat can drop that table
  def self.drop_table
      sql = <<-SQL
        DROP TABLE students
        SQL
      DB[:conn].execute(sql)
  end

  #Method save that can save the data concerning an individual student object to the database
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
      SQL

      DB[:conn].execute(sql, self.name, self.grade)

      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  #Method that creates a new instance of student class and then saves it to the database

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end

end
