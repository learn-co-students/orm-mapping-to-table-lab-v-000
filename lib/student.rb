class Students
    attr_accessor :name, :grade
    attr_reader :id

    def initialize(name, grade, id = nil)
        @name = name
        @grade = grade
        @id = id
    end

    def self.create_table
        sql = <<-SQL
        CREATE TABLE IF NOT EXISTS songs(
            id INTERGER PRIMARY KEY,
            name TEXT, grade TEXT
        )
        SQL
        DB[:conn].execute(sql)
    end


    def self.drop_table
    sql > DROP TABLE students;
    DB[:conn].execute(sql)
    end


    def save
        sql = <<-SQL
        INSERT INTO songs (name, grade)
        VALUES (?,?)
        SQL
        DB[:conn].execute(sql, self.name, self.grade)
        @id = DB[:conn].execute("SELECT last_insert_rowid()FROM songs")[0][0]
    end


    def self.create(name:, grade:)
        student = student.new(name, grade)
        student.save
        student
    end


end
