class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  

  attr_accessor :name, :grade
  attr_reader :id

  def initialize (name, grade)
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = "create table students (id integer primary key, name text, grade text)"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "drop table students"
    DB[:conn].execute(sql)
  end

  def save
    sql = "INSERT INTO students (name, grade) VALUES (?, ?)"
    DB[:conn].execute(sql, @name, @grade)
    @id = DB[:conn].execute("Select last_insert_rowid() from  students")[0][0]
  end

  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save
    student
  end
  
end
