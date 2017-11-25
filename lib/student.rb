class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(id=nil, name, grade)
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-HEREDOC
      CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        );
          HEREDOC

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE students"

    DB[:conn].execute(sql)
  end

  def self.create(name:, grade:)
    new_student = Student.new(name, grade)
    new_student.save
    new_student
  end

  def save    
    sql = "INSERT INTO students (name, grade) VALUES (?, ?)"
      
    DB[:conn].execute(sql, self.name, self.grade) 

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]  
  end  
  
end