module University
  class Course < ApplicationRecord

    #def self.create_courses_from_api
    #  SFUApi.find_dept
    #    .map {|dept| Course.new ({}) }
    #  
    #end

    def self.lipsumApi
      @@lipsumApi ||= LipsumApi.new
    end

    def self.create_from_api
        Program.all.each{|program| create_from_api_to_program program }
    end

    def self.create_from_api_to_program program
        SFUAPi.find_courses(program)
            .map  {|hcourse|
                      c = Course.new ({name:hcourse["title"], description:generate_description(), program:program})
                  }
            .each {|course| 
                    course.save
                    course
                }
    end

    def self.generate_description
       lipsumApi.get_lipsum (3 + Ramdom.rand(3))
    end
  end
end
