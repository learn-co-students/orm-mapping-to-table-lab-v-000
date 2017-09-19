require "pry"
class Student
  attr_accessor :name, :grade
  attr_reader :id
  @@all = []

  def initilize(name = "", grade= "", id= nil)
    @id = id
    @name = name
    @grade = grade
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_table()
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )
        SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table()
    sql =  <<-SQL
      DROP TABLE students
        SQL
    DB[:conn].execute(sql)
  end

  def save(name, grade)
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?, ?)", name, grade)
  end

end
