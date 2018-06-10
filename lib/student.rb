class Student

  attr_accessor :name, :grade
  attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  def initialize(name,grade,id=nil)
    @name=name
    @grade=grade
  end


  def self.create_table
    sql=<<-SQL
      CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INT
      )
      SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql="DROP TABLE students"
    DB[:conn].execute(sql)
  end

  def save
    sql="INSERT INTO students(name, grade) VALUES(?,?)"    #inserts student attributes into the database
    DB[:conn].execute(sql,self.name,self.grade)     #executes the statement above with name and grade bound variables
    @id=DB[:conn].execute("SELECT last_insert_rowid() FROM students").flatten.first   #gets the last inserted row id and flattens it, gets the first element (the actual ID)
  end

  def self.create(stu_hash)
    stu=Student.new(stu_hash[:name],stu_hash[:grade])
    @id=stu.save
    stu
  end



end
