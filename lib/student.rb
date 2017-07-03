class Student

  # DB[:conn]

  attr_accessor :name, :grade
  attr_reader :id



  def initialize(name, grade)
    @name = name
    @grade = grade
  end



  def self.create_table
    DB[:conn].execute(
      <<~SQL
      CREATE TABLE IF NOT EXISTS
      students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT);
    SQL
    )

  end



  def self.drop_table
    DB[:conn].execute(
      <<~SQL
      DROP TABLE IF EXISTS students;
    SQL
    )

  end



  def save
    DB[:conn].execute("INSERT INTO students (name, grade)
    VALUES (?,?);", @name, @grade)

    @id = DB[:conn].execute("SELECT MAX(id) FROM students;")[0][0]
  end



  def self.create(name:, grade:)
    self.new(name, grade).tap do |student|
      student.save
    end
  end

end
