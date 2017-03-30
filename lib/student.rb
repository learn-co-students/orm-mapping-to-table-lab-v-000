class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  #attributes and variables
  attr_accessor :name, :grade
  attr_reader :id

  #initialize
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  #class methods
  def self.create_table
    sql =<<-sql
      CREATE TABLE IF NOT EXISTS students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
    sql

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql =<<-sql
      DROP TABLE students;
    sql

    DB[:conn].execute(sql)
  end

  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save
    student
  end


  #instance methods
  def save
    sql = <<-sql
      INSERT INTO students(name, grade) VALUES
      (?,?);
    sql

    id_pull = <<-sql
      SELECT last_insert_rowid() FROM students;
    sql

    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute(id_pull)[0][0]
  end

end
