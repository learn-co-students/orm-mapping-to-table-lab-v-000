class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize (name, grade, id=nil)
    self.name = name
    self.grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )
    SQL

    DB[:conn].execute(sql)
  end

  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save
    student
  end

  def self.drop_table
    sql = <<-SQL
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


end

# class Song
#   attr_accessor :name, :album, :id
#
#   def initialize(name, album, id=nil)
#     self.name = name
#     self.album = album
#     self.id = id
#   end
#
#   def self.create_table
#     sql = <<-SQL
#       CREATE TABLE IF NOT EXISTS songs (
#         id INTEGER PRIMARY KEY,
#         name TEXT,
#         album TEXT
#       )
#     SQL
#
#     DB[:conn].execute(sql)
#   end
#
#   def self.create(name: album:)
#     song = self.new(name, album)
#     song.save
#     song
#   end
#
#   def save
#     sql = <<-SQL
#         INSERT INTO songs (name, album)
#         VALUES (?, ?)
#     SQL
#
#     DB[:conn].execute(sql, self.name, self.album)
#
#     self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
#    #self.id = DB[:conn].execute("SELECT id FROM songs WHERE name = ?", self.name)
#
#   end
#
# end
