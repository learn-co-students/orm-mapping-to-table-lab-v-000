class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  attr_reader :id
  attr_accessor :name, :grade

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      create table if not exists students (
        id integer primary key,
        name text,
        grade integer
      );
    SQL

    DB[:conn].execute(sql)

  end

  def self.drop_table
    sql = <<-SQL
      drop table students;
    SQL

    DB[:conn].execute(sql)
  end
      
  def save
    sql = <<-SQL
      insert into students (name, grade)
      values (?, ?);
    SQL

    DB[:conn].execute(sql, @name, @grade)

    sql = <<-SQL
      select last_insert_rowid() from students
    SQL

    @id = DB[:conn].execute(sql)[0][0]
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end
  
end
