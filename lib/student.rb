class Student
	attr_accessor :name, :grade
	attr_reader :id

	def initialize(name, grade, id=nil)
		@name = name
		@grade = grade
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

	def self.drop_table 
		sql = <<-SQL
		DROP TABLE IF EXISTS students 
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

  # def self.create(name:, album:)
  #   song = Song.new(name, album)
  #   song.save
  #   song
  # end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  


# class Song
 
#   attr_accessor :name, :album, :id
 
#   def initialize(name, album, id=nil)
#     @id = id
#     @name = name
#     @album = album
#   end
 
#   def self.create_table
#     sql =  <<-SQL 
#       CREATE TABLE IF NOT EXISTS songs (
#         id INTEGER PRIMARY KEY, 
#         name TEXT, 
#         album TEXT
#         )
#         SQL
#     DB[:conn].execute(sql) 
#   end
 
#   def save
#     sql = <<-SQL
#       INSERT INTO songs (name, album) 
#       VALUES (?, ?)
#     SQL
 
#     DB[:conn].execute(sql, self.name, self.album)
 
#   end
 
# end