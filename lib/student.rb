class Student
  attr_reader :id
  attr_accessor :name, :grade

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
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save
    student
  end

  def initialize(name, grade, id = nil)
    @name, @grade, @id = name, grade, id
  end

  def save
    sql = "INSERT INTO students (name, grade) VALUES (?, ?);"
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students").first.first
  end

end
