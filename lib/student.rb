class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name,:grade
  attr_reader :id

  def initialize (name,grade)
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
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
    #add to db
    sql1 = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (
        ?,
        ?
      );
      SQL
    DB[:conn].execute(sql1, @name, @grade)

    #update object's id
    sql2 = <<-SQL
      SELECT last_insert_rowid()
      FROM students
      SQL
    @id = DB[:conn].execute(sql2)[0][0]
    self
  end

  def self.create(name:,grade:)
    obj = self.new(name,grade)
    obj.save
  end
end
