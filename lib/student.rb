class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  attr_accessor :name, :grade
  attr_reader :id

  def initialize (name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    #sql query to create table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    grade INTEGER);
    SQL

    #connect to database and execute sql query
    DB[:conn].execute(sql)
  end

  def self.drop_table
    #sql query to drop table
    sql = <<-SQL
    DROP TABLE students;
    SQL

    #connect to database and execute sql query
    DB[:conn].execute(sql)
  end

  def save
    #sql query to insert student object attributes into table in database
    sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?, ?);
    SQL

    #connect to database and execute sql query
    DB[:conn].execute(sql, self.name, self.grade)

    #set id attribute equal to primary key from table in database
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students;")[0][0]
  end

  def self.create(name:, grade:)
    Student.new(name, grade).tap do |student|
      student.save
    end
    #Long form code is:
      #student = Student.new(name,grade)
      #student.save
      #student
  end  
  
end
