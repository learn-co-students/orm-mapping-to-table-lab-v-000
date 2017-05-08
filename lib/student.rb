class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    DB[:conn].execute(<<-SQL)
      CREATE TABLE IF NOT EXISTS students(
          id INTEGER PRIMARY KEY,
          name TEXT,
          grade INTEGER
      );
    SQL
  end

  def self.drop_table
    DB[:conn].execute(<<-SQL)
      DROP TABLE students;
    SQL
  end

  def save
    DB[:conn].execute(<<-SQL, self.name, self.grade)
      INSERT INTO students (name, grade)
      VALUES (?, ?);
    SQL
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students;")[0][0]
  end

  def self.create(name:, grade:)
    Student.new(name, grade).tap{|student| student.save}
  end
end
