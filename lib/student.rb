class Student
  attr_accessor :name, :grade
  attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def initialize(name, grade, id=nil)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      );
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE IF EXISTS students;
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql_insert = <<-SQL
      INSERT INTO students(name, grade)
      VALUES (?,?);
    SQL
    sql_add_id = <<-SQL
      SELECT last_insert_rowid() FROM students;
    SQL
    DB[:conn].execute(sql_insert, self.name, self.grade)
    @id = DB[:conn].execute(sql_add_id)[0][0]
  end

  def self.create(name:, grade:)
    new_student = Student.new(name, grade).tap do |student|
      student.save
    end
  end

end
