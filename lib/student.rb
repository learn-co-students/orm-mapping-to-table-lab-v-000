class Student
  attr_accessor :name, :grade
  attr_reader :id

  @@all = []

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  def initialize(name, grade, id: nil)
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
      )
      SQL
      DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS students")
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, @name, @grade)
    @id = DB[:conn].execute("SELECT id FROM students WHERE name = ?", @name)[0][0]
  end

  def self.all
    @@all
  end

  def self.create(attributes)
    student = Student.new(nil, nil)
    attributes.each { |key, value| student.send("#{key}=", value) }
    student.save
    student
  end
end
