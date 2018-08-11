class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    @id = nil
    @name = name
    @grade = grade
  end #initialize

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY key,
        name TEXT,
        grade INTEGER
      )
    SQL

    DB[:conn].execute(sql)
  end #create_table

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL

    DB[:conn].execute(sql)
  end #drop_table

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?,?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end #save

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end #create


  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end
