require 'pry'
class Student
  attr_accessor :name, :grade
  attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def initialize(name, grade)
    self.name = name
    self.grade = grade
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
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
      INSERT INTO students(name, grade) VALUES (?, ?);
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
    saved_data = DB[:conn].execute("SELECT * FROM students WHERE name = ?", self.name)
    @id = saved_data[0][0] # 0 element contains the values for the query as nested array, 0 of the nested array contains the id
    saved_data
  end

  def self.create(name:, grade:)
    self.new(name, grade).tap{|student| student.save}
  end

end
