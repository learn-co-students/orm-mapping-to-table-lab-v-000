class Student
  
  attr_accessor :name, :grade
  attr_reader :id
  
  def initialize(id = nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end
  
  def self.create_table
    DB[:conn].execute("CREATE TABLE IF NOT EXISTS students(id INTEGER PRIMARY KEY, name TEXT, grade TEXT)")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS students")
  end
  
  def save
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?, ?)", self.name, self.grade)
    @id = DB[:conn].execute("SELECT id FROM students WHERE name = ?", self.name)[0][0]
  end
  
  def self.create(hash)
    student = self.new(name = hash[:name], grade = hash[:grade])
    student.save
    student
  end
  
end
