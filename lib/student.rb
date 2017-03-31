class Student
    attr_accessor :name, :grade
    attr_reader :id
    
    def initialize(name, grade, id = nil)
      @name = name
      @grade = grade
      @id = id
    end

    def self.create_table
      sql = <<-SQLite3
        CREATE TABLE students (
          id INTEGER PRIMARY KEY,
          name TEXT,
          grade INTEGER
        );
      SQLite3
      DB[:conn].execute(sql)
    end

    def self.drop_table
      sql = <<-SQLite3
        DROP TABLE students;
      SQLite3
      DB[:conn].execute(sql)
    end

    def save
      sql = <<-SQLite3
        INSERT INTO students (name, grade) VALUES (?, ?);
      SQLite3
      DB[:conn].execute(sql, @name, @grade)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end

    def self.create(options = {name: nil, grade: nil})
      new_student = self.new(options[:name], options[:grade])
      new_student.save
      new_student
    end
end
