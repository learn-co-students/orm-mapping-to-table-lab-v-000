class Student
#Student` class
# 'name` and a `grade'
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
  	@id = id
  	@name = name
  	@grade = grade
  end
 #1. Write a class that is mapped, or equated, to a database table.
 #2. Build a method that creates a table that maps to the given class.
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
  #3. Write a method that drops that table.
  def self.drop_table
  	sql = <<-SQL
  	DROP TABLE students
  	          SQL

  	 DB[:conn].execute(sql)
  end
  #4. Write a method that saves a given instance to the database table.
  def save
  	sql = <<-SQL
  	INSERT INTO students (name, grade)
  	VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
   end
### The `.create` Method
#This is a class method that uses keyword arguments.
#The keyword arguments are `name:` and `grade:`.
#Use the values of these keyword arguments to:
#1) instantiate a new `Student` object with `Student.new(name, grade)`
#and 2) save that new student object
#via `student.save`. The `#create` method should return the student object that it creates.
  def self.create(name:, grade:)
  	student = Students.new(name, grade)
  	student.save
  	student
  end

end
