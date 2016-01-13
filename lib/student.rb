class Student

	attr_accessor :name, :grade
	attr_reader :id
	def initialize(name, grade, id=nil)
		@name=name
		@grade=grade
		@id=id
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
		DB[:conn].execute("DROP TABLE IF EXISTS students")
	end

	def save
		DB[:conn].execute("INSERT INTO students(name, grade) VALUES(?, ?)", @name, @grade)
		@id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
	end

	def self.create(name:, grade:, id:nil)
		new_instance = self.new(name, grade, id)
		new_instance.save
		new_instance
	end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end
