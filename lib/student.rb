class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @id = id
    @name = name
    @grade = grade
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
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)  
  end

  def save
    sql = <<-SQL 
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade) 
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  # This method will wrap the code we used above to create a new Student instance and save it  
  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end




  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end
