require 'pry'

class Student

  attr_accessor :name, :grade, :db
  attr_reader :id

    def initialize(name, grade)
      @name = name
      @grade = grade
      @id = id
      @db = db
    end

    # def self.create_table
    #   sql = DB[:conn].execute('CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, grade VARCHAR);')
    # end
    #
    # def self.drop_table
    #   sql = DB[:conn].execute('DROP TABLE IF EXISTS students;')
    # end

    def save

      sql = DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?, ?)", name, grade)

      value = DB[:conn].execute("SELECT id FROM students ORDER BY ID DESC LIMIT 1;").flatten
      @id = value[0][0]
      binding.pry
      # INSERT INTO Student name, grade VALUES (?, ?)
    # DB[:conn].execute(sql, self.name, self.album)
end
    def self.create(name:, grade:)

  #     students = Student.new(id: id, name: name, grade: grade)
  # id = students[0]
      # student.sql = DB[:conn].execute('SELECT * FROM students ORDER BY ID DESC LIMIT 1')
students.delete("")
students = DB[:conn].execute("SELECT * FROM students ORDER BY ID DESC LIMIT 1;").flatten

return students.to_a.last
# return

      # return student.last
    end

  end
