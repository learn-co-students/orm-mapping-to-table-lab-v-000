class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  attr_accessor :name, :grade
  attr_reader :id

  def initialize (name, grade, id=nil)
    @name= name
    @grade= grade
    @id= id
  end

  def self.create_table
    sql = <<-SQL 
     CREATE TABLE IF NOT EXISTS students (
       id INTEGER PRIMARY KEY, name TEXT, grade TEXT)
      SQL
    DB[:conn].execute(sql) 
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
      SQL
    DB[:conn].execute(sql)
  end

  def save(name, grade)
    sql = <<-SQL
     INSERT INTO students (name, grade) VALUES (?, ?)",
     name, grade)
     SQL
    DB[:conn].execute(sql)
    new_id = DB[:conn].execute("SELECT id FROM students ORDER BY id DESC LIMIT 1")
    self.id = new_id
  end



end
