
require_relative '../config/environment.rb'

class Student
#----------------------------------------------------------------
#macros, etc.
attr_accessor :name, :grade
attr_reader :id


#----------------------------------------------------------------
#instance
def initialize (name, grade, id = nil)
@name = name
@grade = grade
@id = id
end




def save
DB[:conn].execute("INSERT INTO students (name, grade) values (?,?)", @name, @grade)
@id = DB[:conn].last_insert_row_id
end



#----------------------------------------------------------------
#class
def self.create (hash = {})

name = ""
grade = ""

hash.each{|key,value| 
                      if key == :name
                      name = value
                      elsif key == :grade
                      grade = value
                      end
 
        }
new_student = Student.new(name,grade)
new_student.save
new_student

end

def self.drop_table
sql = "DROP TABLE students"
DB[:conn].execute(sql)

end



def self.create_table 
      sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students 
      (id INTEGER PRIMARY KEY, 
       name TEXT,
       grade TEXT
       )
       SQL

DB[:conn].execute(sql) 
end






  
#----end of class  
end
