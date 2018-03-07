class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(id=nil, name, grade)
    @name = name
    @grade = grade

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
    #insert statement here
    #then assign id to object as an attribute
  end


end
