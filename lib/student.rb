class Student

attr_accessor :name, :grade
attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
      SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE students"
    DB[:conn].execute(sql)
  end

  def save
    sql_insert = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
      SQL

    DB[:conn].execute(sql_insert, self.name, self.grade)

    sql_select = <<-SQL
      SELECT last_insert_rowid()
      FROM students
      SQL
    @id = DB[:conn].execute(sql_select)[0][0]
  end

  def self.create(hash_of_attributes)

    hash_of_attributes.each do |key, value|
      DB[:conn].execute("INSERT INTO students (#{key}) VALUES (?)", value)
    end

    binding.pry

    Student.new()

  end


end
