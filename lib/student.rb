class Student
attr_accessor :name, :grade
attr_reader :id

  def initialize(name, grade)
    @name = name
    @grade = grade
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

  def self.drop_table
    DB[:conn].execute("DROP TABLE students;")
  end

  def self.create(student_hash)
    # binding.pry
    new_student = Student.new(student_hash[:name], student_hash[:grade])
    new_student.save
    return new_student
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
    result = DB[:conn].execute("SELECT last_insert_rowid() FROM students").flatten
    # binding.pry
    @id = result[0]
  end

end
