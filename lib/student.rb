require "sqlite3"

class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end
  
  def self.create_table
    DB[:conn].execute("CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT);")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS students;")
  end

  def save
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?, ?);", self.name, self.grade)
    @id = DB[:conn].execute("SELECT id FROM students WHERE name = ? AND grade = ?", self.name, self.grade).flatten[0]
  end

  def self.create(attributes)
    student = Student.new(nil, nil)
    attributes.each { |attr, value| student.send("#{attr}=", value)}

    student.save
    student
  end

end
