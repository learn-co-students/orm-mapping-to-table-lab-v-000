class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @id = id
    @name = name
    @grade = grade
  end
  def self.create_table
    create = <<-SQL
      CREATE TABLE IF NOT EXISTS students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INT
        )
        SQL
    DB[:conn].execute(create)
  end
  def self.drop_table
    drop = <<-SQL
      DROP TABLE IF EXISTS students
      SQL
    DB[:conn].execute(drop)
  end
  def save
    save = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
      SQL
    DB[:conn].execute(save, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    self
  end
  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
  end
end
