class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize( id = nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
  # --Grab the ID of that newly inserted row and assigning the given
  # --Song instance's id attribute equal to the ID of its associated database table row.
    @id = DB[:conn].execute('SELECT last_insert_rowid() FROM students')[0][0]
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
      )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end

  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save
    student
  end

end
