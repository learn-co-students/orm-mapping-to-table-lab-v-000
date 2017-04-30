class Student
  attr_accessor :name,:grade
  attr_reader :id

  def self.create_table
    sql = <<-SQL
      CREATE TABLE students(
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
      );
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students;
    SQL

    DB[:conn].execute(sql)
  end

  def self.create(name:,grade:)
    new_student = Student.new(name,grade)
    new_student.save
    new_student
  end


  def initialize(name,grade,id:nil)
    @name = name
    @grade = grade
    @id = id
  end

  def save
    sql = <<-SQL
      INSERT INTO students(name,grade)
      VALUES (?,?);
    SQL
    DB[:conn].execute(sql,self.name,self.grade)

    sql2 = <<-SQL
      SELECT last_insert_rowid()
      FROM students;
    SQL
    @id = DB[:conn].execute(sql2)[0][0]
  end


end
