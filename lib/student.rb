class Student

  attr_accessor :name, :grade
  attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

    def initialize(name, grade, id = nil)
      @name, @grade, @id = name, grade. id
    end

    def .save
    end
end
