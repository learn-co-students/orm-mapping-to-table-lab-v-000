require "pry"
class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id
  @@all =[]

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = nil
    @@all<<self
  end

  def self.all
    @@all
  end

  def save
    insert_str = <<-SQL
    INSERT INTO students (name, grade) VALUES (?, ?)
    SQL
    select_str = <<-SQL
    SELECT last_insert_rowid() FROM students
    SQL
    DB[:conn].execute(insert_str, self.name, self.grade)
    @id = DB[:conn].execute(select_str)[0][0]
  end

  def self.create (name:, grade:)
    student = self.new(name, grade)
    student.save
    student
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    grade TEXT
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

end
