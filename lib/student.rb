class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  attr_accessor:name,:grade
  attr_reader:id

  def initialize(name,grade,id=nil)
    @name= name
    @grade= grade
    @id= id
  end

  def self.create_table
    sql =<<-sql
          CREATE TABLE students(
            id INTEGER Primary Key,
            name TEXT,
            grade TEXT)
          sql
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-sql
          DROP table students
          sql
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-sql
          INSERT into students(name,grade)
          VALUES (?,?)
          sql

    DB[:conn].execute(sql,self.name,self.grade)
    @id = DB[:conn].execute("select last_insert_rowid() from students")[0][0]
  end

  def self.create(name:,grade:)
    student=Student.new(name,grade)
    student.save
    student
  end


  
end
