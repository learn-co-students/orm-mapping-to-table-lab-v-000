#####attributes                                                                                                                                                                                                         
  #has a name and a grade                                                                                                                                                                                           
  #has an id that is readable but not writable                                                                                                                                                                      
#####.create_table                                                                                                                                                                                                      
  #creates the students table in the database                                                                                                                                                                       
#####.drop_table                                                                                                                                                                                                        
  #drops the students table from the database                                                                                                                                                                       
#####save                                                                                                                                                                                                              
  #saves an instance of the Student class to the database                                                                                                                                                           
#####.create                                                                                                                                                                                                            
  #takes in a hash of attributes and uses metaprogramming to create a new student object. Then it uses the #save method to save that student to the database                                                        
  #returns the new object that it instantiated                                                                                                                                                                      
                                                 

class Student
 
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
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
    DROP TABLE IF EXISTS students 
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end
  
end
