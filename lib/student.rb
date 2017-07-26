class Student
  attr_accessor :name, :grade
  attr_reader :id
  def initialize(name,grade)
    @name=name
    @grade=grade
    @id=nil
  end
  def self.create_table
    create_sql= "
     CREATE TABLE IF NOT EXISTS students
     (
       id INTEGER,
       name TEXT,
       grade INTEGER,
       PRIMARY KEY(id)
     )"

     DB[:conn].execute(create_sql)

   end
   def self.drop_table
     del_sql= "DROP TABLE students"
      DB[:conn].execute(del_sql)
   end
   def save
     save_sql=<<-SQL
     INSERT INTO students(name,grade) VALUES (?,?)
     SQL
     DB[:conn].execute(save_sql,@name,@grade)
     #binding.pry
     @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
   end
   def self.create(name:,grade:)
     student = Student.new(name,grade)
     student.save
     student
   end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end
