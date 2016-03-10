class Student
  attr_accessor :name,:grade
  attr_reader :id

def initialize(id=nil,name,grade)
  @name = name
  @grade = grade
end


def self.create_table
sql = <<-SQL
CREATE TABLE students (
id INTEGER PRIMARY KEY,
name TEXT,
grade TEXT
);
SQL

  DB[:conn].execute(sql)
end

def self.drop_table
sql = <<-SQL
DROP TABLE students;
SQL

  DB[:conn].execute(sql)
end

def save
sql = <<-SQL
INSERT INTO students (name,grade) VALUES (?,?);
SQL

  DB[:conn].execute(sql, self.name, self.grade)

sql2 = <<-SQL
SELECT last_insert_rowid() FROM students;
SQL

  @id = DB[:conn].execute(sql2)[0][0]
end

def self.create(hash={name: name,grade: grade})
stud = Student.new(hash[:name],hash[:grade])
  stud.save
  stud
end


end
