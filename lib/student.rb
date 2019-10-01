class Student

  attr_accessor :name, :grade
  attr_reader :id
  
  def initialize(id = nil, name, grade)
    @name = name
    @grade = grade
  end
  
  def self.create_table
    table_script =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade TEXT
        )
      SQL
    DB[:conn].execute(table_script)
  end
    
  def self.drop_table
    full_drop = <<-SQL
      DROP TABLE students
    SQL
    DB[:conn].execute(full_drop)
  end
  
  def save
    row_ins = <<-SQL
      INSERT INTO students (name, grade) VALUES (?, ?)
      SQL
    DB[:conn].execute(row_ins, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
  
  def self.create(stud_hash = {})
    name = stud_hash[:name]
    grade = stud_hash[:grade]
    stud = Student.new(name, grade)
    stud.save
    stud
  end
  
end
