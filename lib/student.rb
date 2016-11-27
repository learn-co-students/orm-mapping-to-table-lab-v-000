class Student
  attr_reader :id
  attr_accessor :name, :grade

  def initialize(name, grade, id=nil) #id has to be kept nil, as it is to be assigned by the database
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL #using heredoc to insert multiline SQL code
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      );
      SQL
    DB[:conn].execute(sql)
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
      VALUES (?, ?);
      SQL

    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    #[0][0] - here the first array is the row of the database and then the second array is the student itself who's id we want
    #selecting the id from the last created row in the database and adding it to student object to replicate the exact database
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student #Returning the student object after creation is required by the spec
  end

end
