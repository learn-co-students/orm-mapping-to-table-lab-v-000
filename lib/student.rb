class Student

  attr_accessor :student, :grade, :id

  def initialize (student, grade, id = nil)
    @student = student
    @grade = grade
    @id = id
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end
