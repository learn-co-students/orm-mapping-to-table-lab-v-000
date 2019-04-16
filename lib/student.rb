class Student
  attr_accessor :name, :grade
  attr_reader :id
  def initialize name=nil, grade=nil
    @name=name; @grade=grade; @id=nil
  end

  def self.create_table
    DB[:conn].execute("CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER)")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS students")
  end
  
  def save
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?, ?)", @name, @grade)
    @id=DB[:conn].execute("SELECT id FROM students WHERE name IS ?", @name)[0][0]
  end

  def self.create h
    r=self.new
    h.each{|key,value| r.send("#{key}=",value)}
    r.save
    r
  end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end
