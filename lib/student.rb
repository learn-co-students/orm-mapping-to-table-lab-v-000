class Student

  attr_reader :id
  attr_accessor :name, :grade

  def initialize(name, grade, id = nil)
    @name, @grade, @id = name, grade, id
  end

  def self.create_table
    DB[:conn].execute("CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT)")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end

  def save
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?,?)", @name, @grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students").first.first
  end

  def self.create(hash)
    student = self.new(hash[:name], hash[:grade])
    student.save
    student
  end

end
