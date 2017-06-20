module University
  class Grade < ApplicationRecord
	  belongs_to :course


    def self.create_for_students
      students = Student.all
      students.each{|student|
        qtd = Random.rand(Course.find)
        #Course.find_by_program(student.program).order("random()").limit(qtd).each{|course|
        #  grade = Grade.new {grade:(5+Random.rand(5)), course:course, student:student}
        #  grade.save
        #}
      }
    end

  end
end
