class Student
  attr_accessor :name, :grade
  attr_reader :id

def initialize(name, grade, id=nil)
  @name=name
  @grade=grade
  @id = id
end

def self.create_table
  sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER)
      SQL
      DB[:conn].execute(sql)
end

def self.drop_table
  DB[:conn].execute("DROP TABLE students")
end

def save
  sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students") [0][0] #bound parameters. grabbing the value of he last ID column of the last inserted row and set that equal to the given student instance's id attribute.
  end

  def self.create(name:, grade:)
    beyonce = Student.new(name, grade)
    beyonce.save
    beyonce
  end

end
