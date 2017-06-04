class Student
  attr_accessor :name, :grade
  attr_reader :id

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
        grade TEXT
        )
        SQL
    DB[:conn].execute(sql)
  end

  def save
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?, ?)", self.name, self.grade)
    @id = DB[:conn].execute("SELECT * FROM students ORDER BY id DESC LIMIT 1").flatten[0]
  end

  def self.create(name:, grade:)
    new_student = self.new(name, grade)
    new_student.save
    new_student
  end

  def self.drop_table
     DB[:conn].execute("DROP TABLE IF EXISTS students")
   end

end
