class Student
  attr_accessor :name, :grade
  attr_reader :id #we have no need to edit the id this is all done through SQL

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )
        SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql =  <<-SQL
      DROP TABLE students;
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
    #Grabbing the ID of that newly inserted row and assigning the given Song instance's id attribute equal to the ID of its associated database table row.
    end

   def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
   end



end
