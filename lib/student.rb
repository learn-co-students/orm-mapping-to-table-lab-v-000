require 'pry'

class Student

  attr_accessor :name, :grade

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
      INSERT INTO students (id, name, grade) 
      VALUES (?, ?);
    SQL
    @id = self.id.last

    DB[:conn].execute(sql, self.name, self.grade)

    # binding.pry

  end

  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.each {|key, value| self.send(("#{key}="), value)}
    self.save
  end
end
  
  
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  