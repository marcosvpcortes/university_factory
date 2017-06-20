FactoryGirl.define do

  factory :student, :class=>University::Student do
    name "John"
    join "john"
    password "xxx"
    age 21
    region "RJ (BR)"
    email "john@gmail.com"
    phone "000"
    

    after(:build) {|s| s.program = FactoryGirl.build(:program)}
  end

  factory :program, :class=>University::Program do
    name "Computer Science"
    code "CS"

    factory :program_1, :class=>University::Program do
    end
  end

  factory :program_2, :class=>University::Program do
    name "History"
    code "HS"
  end

  factory :program_3, :class=>University::Program do
    name "USA"
    code "USA"
  end
end
