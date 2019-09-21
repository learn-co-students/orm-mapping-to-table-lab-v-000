class Student

 attr_reader :id, :name, :grade
 
  def initialize(id = nil, name, grade )
    @id = id 
    @name = name 
    @grade = grade 
  end 
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  

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
 
 end 
