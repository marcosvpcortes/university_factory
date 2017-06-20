module University
  class Student < ApplicationRecord
    belongs_to :program

    STUDENT_API_QUERY_COUNT = 200

    def self.create_students_from_api
      response =  RestClient.get "https://randomuser.me/api/", {params:{nat:"BR, US, FR", results:STUDENT_API_QUERY_COUNT}, content_type: :json, accept: :json}

      JSON.parse(response.body)["results"]
          .map{|r| hash_to_student r}
          .map {|student| student.save
               student}
    end

    def self.hash_to_student hash
      student = Student.new
      student.name = "#{hash["name"]["first"]} #{hash["name"]["last"]}"
      student.age  = 18 + Random.rand(20)
      student.login= hash["login"]["username"]
      student.password = hash["login"]["password"]
      student.region = "#{hash["location"]["state"]} (#{hash["nat"]})"
      student.email = hash["email"]
      student.phone = hash["phone"]
      student.program = Program.random      
      student.save
      student
    end
   	
  end
end
