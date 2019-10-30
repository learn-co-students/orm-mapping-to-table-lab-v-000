require 'pry'
class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    @name = name
    @grade = grade
    @id = nil
  end

  def self.create_table
    sql = <<-SQL
            CREATE TABLE IF NOT EXISTS students (
              id INTEGER PRIMARY KEY,
              name TEXT,
              grade TEXT
            );
          SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
            DROP TABLE students;
          SQL

    DB[:conn].execute(sql)

  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0] # array in array with one value: [[0]]
    # binding.pry
  end

  def self.create(kid)
    student = Student.new(kid[:name], kid[:grade])
    student.save
    student
  end

end
