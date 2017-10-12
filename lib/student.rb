class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize (name, grade, id = nil)
    @name = name
    @grade = grade
  end

  def self.create_table #create the table before inserting values into it
    sql = <<-SQL
            CREATE TABLE IF NOT EXISTS students(
                                                id INTEGER PRIMARY KEY,
                                                name TEXT,
                                                grade INTEGER
                                              )
          SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table  #delete the table
    sql = <<-SQL
            DROP TABLE students
          SQL
    DB[:conn].execute(sql)
  end
  def save
    sql = <<-SQL
            INSERT INTO students (name, grade)
            VALUES (?,?)
          SQL
    DB[:conn].execute(sql, self.name, self.grade) #self.name and self.grade fill in the ?, ? in the sql variable
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    #the above code goes intothe database and selects the id of the row that was added and then assigns that value to our objects id attribute
  end
  def self.create(name:, grade:)  #these class method uses keyword arguments
      student = Student.new(name, grade)
      student.save
      student
  end


end
