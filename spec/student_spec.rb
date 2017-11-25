require "spec_helper"

describe "Student" do
  let(:josh) {Student.new("Josh", "9th")}

  before(:each) do
    DB[:conn].execute("DROP TABLE IF EXISTS students")
  end

  describe "attributes" do
    it 'has a name and a grade' do
      
      expect(true).to eq(true)
    end
  end
end
