class Student

  def self.create_table
    sql_table_create = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      ); 
    SQL
    
    DB[:conn].execute(sql_table_create)
  end

  def self.drop_table 
    sql_drop_table = <<-SQL
      DROP TABLE IF EXISTS students;
    SQL
    DB[:conn].execute(sql_drop_table)
  end

  def self.create(name: , grade:)
    student = self.new(name, grade)
    student.save
  end
  
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def save
    sql_add = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (? , ?);
    SQL
    sql_update = <<-SQL
      UPDATE students SET name = ?, grade = ? WHEN id = ? ;
    SQL
    if self.id.nil?
      DB[:conn].execute(sql_add, self.name, self.grade)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students;")[0][0]
      self
    else
      DB[:conn].execute(sql_update, self.name, self.grade, self.id)
    end
  end

end
