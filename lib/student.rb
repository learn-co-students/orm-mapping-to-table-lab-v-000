class Student
<<<<<<< HEAD
    attr_accessor :name, :grade
    attr_reader :id

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def initialize(name, grade, id = nil)
  	@name, @grade, @id = name, grade, id
  end

  def self.create_table
  	sql = <<-SQL
=======
	attr_accessor :name, :grade
	attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  def initialize(name, grade, id = nil)
  	@name, @grade, @id = name, grade, id 
  end

  def self.create_table 
  	sql = <<-SQL 
>>>>>>> 167ddfe6f6ba65a6429fae8150a6525592fad1f8
  		CREATE TABLE IF NOT EXISTS students(
  			id INTEGER PRIMARY KEY,
  			name TEXT,
  			grade INTEGER
  			)
  			SQL
  			DB[:conn].execute(sql)
  end

<<<<<<< HEAD
  def self.drop_table
=======
  def self.drop_table 
>>>>>>> 167ddfe6f6ba65a6429fae8150a6525592fad1f8
  	sql = <<-SQL
  		DROP TABLE students
  		SQL
  		DB[:conn].execute(sql)
  end

  def save
  	sql = <<-SQL
  		INSERT INTO students (name, grade) VALUES (?,?)
  		SQL
  		DB[:conn].execute(sql, self.name, self.grade)
  		@id = DB[:conn].execute("SELECT last_insert_rowid()").flatten[0]
  end

  def self.create(name:, grade:)
  	student = Student.new(name, grade)
  	student.save
  	student
  end

<<<<<<< HEAD
=======

>>>>>>> 167ddfe6f6ba65a6429fae8150a6525592fad1f8
end


