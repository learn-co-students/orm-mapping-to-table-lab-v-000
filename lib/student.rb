class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
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
    DB[:conn].execute("DROP TABLE students")
  end

  def save
    DB[:conn].execute("INSERT INTO students (id, name, grade) VALUES (?,?,?)", @id, @name, @grade)
    id_table = DB[:conn].execute("SELECT id FROM students WHERE name = (?)", self.name)
    @id=(id_table)[0][0]
  end

  def self.create(name:, grade:)
    new_s = Student.new(name,grade)
    new_s.save
    new_s
  end

end
