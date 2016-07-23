class Student
  attr_reader :name, :grade, :id

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
      );
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students;")
  end

  def save
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?, ?);", name, grade)
    @id = DB[:conn].execute("SELECT id FROM students ORDER BY id DESC LIMIT 1;").first.first
    self
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade).save
  end
end
