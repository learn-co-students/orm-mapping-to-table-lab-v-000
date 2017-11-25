class Student
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id
  #attr_writer :id
  def initialize(name, grade, id=nil)
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
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
  	student = Student.new(name, grade)
  	student.save
  	student
  end

end
