class Student
  attr_reader :id, :name, :grade
  def initialize(name, grade, id=nil)
    @name, @grade, @id = name, grade, id
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name,grade)
      VALUES (?,?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT id FROM students ORDER BY id DESC LIMIT 1;").flatten[0]
  end

  def self.create(name:, grade:)
    sql = <<-SQL
      INSERT INTO students (name,grade)
      VALUES (?,?)
    SQL
    DB[:conn].execute(sql, name, grade)
    id = DB[:conn].execute("SELECT id FROM students ORDER BY id DESC LIMIT 1;").flatten[0]
    new_Student = new(name, grade, id)
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )
      SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE students"
    DB[:conn].execute(sql)
  end

end
