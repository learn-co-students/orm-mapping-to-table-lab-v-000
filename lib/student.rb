require 'pry'

class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
      sql =  <<-SQL 
        CREATE TABLE IF NOT EXISTS students (
          id INTEGER PRIMARY KEY, 
          name TEXT,
          grade INTEGER
          )
          SQL
      DB[:conn].execute(sql) 
  end

  def self.drop_table 
    sql =  <<-SQL 
    DROP TABLE students
      SQL
    DB[:conn].execute(sql) 
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?);
    SQL
  #  binding.pry
    # @id = self.id
    DB[:conn].execute(sql, self.name, self.grade)
    new_id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")
    @id = new_id.flatten[0]
    # binding.pry
  end

  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.each {|key, value| self.send(("#{key}="), value)}
    self
  end
end
  
  
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  