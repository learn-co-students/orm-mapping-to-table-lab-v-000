class Student
  attr_accessor :name, :grade
  attr_reader :id
  def initialize (name, grade)
    @name = name
    @grade = grade
    @id = nil
  end

  def self.create_table
    sql =  "CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("drop table students")
  end

  def save
   sql = "INSERT INTO students (name, grade)
      VALUES (?, ?)"
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(hash)
    noob = Student.new(hash[:name], hash[:grade])
    noob.save
    noob
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end
