#!/usr/bin/env ruby

class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @id = id
    @name = name
    @grade = grade
  end
 
  def self.create_table
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade TEXT
        )
        SQL
    DB[:conn].execute(sql) 
  end

  def self.drop_table
    sql = 
      <<-SQL
      DROP TABLE IF EXISTS students
      SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = 
      <<-SQL
        INSERT INTO students (name, grade) 
          VALUES (?, ?)
      SQL
      
    DB[:conn].execute(sql, self.name, self.grade)
    p @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

 # .create
 # 1. makes Ruby object Student.new
 # 2. #save INSERTs object into db table AND
 # 3. #save reads last inserted row ID in db table as the object
 #    that is returned by Student.create method
  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end
end

