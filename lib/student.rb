class Student
attr_accessor :name, :grade
attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def initialize(name, grade, id=nil)
    @id, @name, @grade = id, name, grade
  end #def initialize
###################################
  def self.create_table
    sql= <<-TEXT
CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT)
    TEXT
    DB[:conn].execute(sql)
  end #end the create table method
###################################
  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS students")
  end #end the drop table
###################################
  def save
    DB[:conn].execute(("INSERT INTO students (name, grade) VALUES (?,?)"), self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end #end the save method
###################################
  def self.create(name:, grade:)
      student = Student.new(name, grade)
      student.save
      student
    end#end the create method
end
