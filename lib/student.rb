class Student
  attr_accessor :name, :grade
  attr_reader  :id

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
        grade TEXT
        )
    SQL

    DB[:conn].execute(sql) # access the DB constant and the database connection it holds
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade) # bound parameters

     # assign ID of that newly inserted row to be the value of hello's id attribute
	   @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end

end
