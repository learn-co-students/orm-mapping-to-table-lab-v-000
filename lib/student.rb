class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(id=nil, name, grade)
   @id = id
   @name = name
   @grade = grade
  end

  def self.create_table
  sql = "
  CREATE TABLE IF NOT EXISTS students(
  id INTEGER PRIMARY KEY,
  name TEXT,
  grade INTEGER
  )
  "
  DB[:conn].execute(sql)
  end

  def self.drop_table
   drop = "DROP TABLE IF EXISTS students"
   DB[:conn].execute(drop)
  end

  def save
   save = "
   INSERT INTO students (name, grade) VALUES (?, ?)
   "
   DB[:conn].execute(save, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save
    student
  end





end
