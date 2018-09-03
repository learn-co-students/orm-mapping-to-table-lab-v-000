require "spec_helper"

describe "Student" do
  let(:josh) {Student.new("Josh", "9th")}

  before(:each) do
    DB[:conn].execute("DROP TABLE IF EXISTS students")
  end

  describe "attributes" do
    it 'has a name and a grade' do
      student = Student.new("Tiffany", "11th")
      expect(student.name).to eq("Tiffany")
      expect(student.grade).to eq("11th")
    end

    it 'has an id that is readable but not writable' do
      expect{josh.id = 1}.to raise_error(NoMethodError)
    end
  end

  describe ".create_table" do
    it 'creates the students table in the database' do
      Student.create_table
      table_check_sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='students';"
      expect(DB[:conn].execute(table_check_sql)[0]).to eq(['students'])
    end
  end

  describe ".drop_table" do
    it 'drops the students table from the database' do
      Student.create_table
      Student.drop_table
      table_check_sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='students';"
      expect(DB[:conn].execute(table_check_sql)[0]).to eq(nil)
    end
  end


end
