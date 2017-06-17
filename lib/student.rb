class Student
  attr_accessor :name, :grade
  attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn] 
  def initialize(name=nil, grade=nil, id = nil)
    @name = name
    @grade = grade
    @id = id
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
    sql = <<-SQL
    DROP TABLE students
    SQL
     DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES(?,?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT MAX(id) FROM students").join.to_i
  end

  def self.create(:name, :grade)#attributes)
    Student.new(name, grade).tap { |student|
      student.save
    }
    # student = Student.new()
    # attributes.each{ |key, value|
    #   student.send("#{key}=", value)
    # }
    # student.save
    # student
  end
  
end
