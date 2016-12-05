class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
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
    #<<- + name of language contained in our multiline statement + the string, on multiple lines + name of language
  end

  def self.drop_table
    sql = <<-SQL
            DROP TABLE IF EXISTS students;
            SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
            INSERT INTO students (name, grade)
            VALUES (?, ?)
            SQL

    DB[:conn].execute(sql, self.name, self.grade)

     @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    #saves an instance of the Student class to the database (FAILED - 3)
  end

  def self.create(name:, grade:)
    new_student = Student.new(name, grade)
    new_student.save
    new_student
    #takes in a hash of attributes and uses metaprogramming to create a new student object. Then it uses the #save method to save that student to the database (FAILED - 4)
    #returns the new object that it instantiated (FAILED - 5)
  end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
end
