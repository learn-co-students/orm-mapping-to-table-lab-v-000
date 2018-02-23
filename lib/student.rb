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
    DB[:conn]
      .prepare(
        "CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT,
        grade TEXT);"
      )
      .execute
  end

  def self.drop_table
    DB[:conn]
      .prepare("DROP TABLE students;")
      .execute
  end

  def save
    insert = DB[:conn]
      .prepare("INSERT INTO students (name, grade) VALUES (?, ?);")
      .execute(self.name, self.grade)
    
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students;")[0][0]
  end

  def self.create(details)
    student = new(details[:name], details[:grade])
    student.save
    student
  end
  
end
