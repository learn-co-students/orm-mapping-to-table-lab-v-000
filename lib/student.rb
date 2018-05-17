class Student

  attr_accessor :name, :grade
  attr_reader :id
  
  def initialize(name, grade)
    @name, @grade = name, grade
  end #initialize
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
        )
    SQL
    
    DB[:conn].execute(sql)
  end #create_table
  
  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL
    
    DB[:conn].execute(sql, self.name, self.grade)
    
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end #save
  
  
  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end #create
  
  def self.drop_table
      DB[:conn].execute("DROP TABLE students")
  end #drop_table
  
end
