class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  #Your `Student` instances should initialize with a name, grade and an optional id. The default value of the `id` argument should be set to `nil`. This is because when we create new `Student` instances, we will not assign them an `id`. That is the responsibility of the database and we will learn more about that later.

  #`Student` attributes should have an `attr_accessor` for `name` and `grade` but only an `attr_reader` for `id`. The only place `id` can be set equal to something is inside the initialize method, via: `@id = some_id`

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @id = id
    @name = name
    @grade = grade

  end




  def self.create_table
    sql =<<-SQL
          CREATE TABLE IF NOT EXISTS students (
            id INTEGER PRIMARY KEY,
            name TEXT,
            grade INTEGER
          )
        SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql =<<-SQL
          DROP TABLE students
        SQL
    DB[:conn].execute(sql)
  end

  def save
     sql = <<-SQL
       INSERT INTO students (name, grade)
       VALUES (?, ?)
     SQL

     DB[:conn].execute(sql, self.name, self.grade)

     @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]

   end

   def self.create(name:, grade:)
     student = Student.new(name, grade)
     student.save
     student
    end
end
