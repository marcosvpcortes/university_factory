require_relative "../spec_helper.rb"

describe University::Program do
  before :each do
  end

  after :each do
  end


  context "when create_from_api" do
    #subject {@all_programs}
    before :each do
      allow(University::SFUApi).to receive(:find_dept) {
JSON.parse(
<<eos
[{
"text": "ACMA",
"value": "acma",
"name": "Actuarial Mathematics"
},
{
"text": "ALS",
"value": "als",
"name": "Applied Legal Studies"
},
{
"text": "APMA",
"value": "apma",
"name": "Applied Mathematics"
}]
eos
)
      }
    end

  after :each do
    @programs.each{|p| p.delete}
  end


    it "should insert three new programs" do
      @programs = University::Program.create_from_api
      @programs = @programs.sort {|a, b| a.code <=> b.code}
      expect(@programs[0].code).to eql("ACMA")
      expect(@programs[1].code).to eql("ALS")
      expect(@programs[2].code).to eql("APMA")
    end

    
  end

  context "when get a random program" do
    subject { @all_programs };
    before :each do
      @programs = [FactoryGirl.create(:program_1),
                  FactoryGirl.create(:program_2),
                  FactoryGirl.create(:program_3)]

      @all_programs = University::Program.all + @programs
    end

    after :each do
      @programs.each{|p| p.delete}
    end

    it "should get some of programs" do
      should include (University::Program.random)
    end
  end
end
