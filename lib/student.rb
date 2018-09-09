class Student
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name,:grade
  attr_reader :id

  def initialize(name,grade,id=nil)
    #id is nil because it will be given from the table.
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    #creates the table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
    id integer PRIMARY KEY,
    name TEXT,
    grade INTEGER
    )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    #deletes the table.
    sql = <<-SQL
    DROP TABLE students;
    SQL
    DB[:conn].execute(sql)
  end

  def save
    #saves the song object to the table
    sql = <<-SQL
    INSERT INTO students (name,grade)
    VALUES
    (?,?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:,grade:)
    #creates the song in ruby so that you don't have to assign it to a variable.
    student = Student.new(name,grade)
    student.save
    student
  end
end
