module University
  class SFUApi
    URL="http://www.sfu.ca/bin/wcm/course-outlines"

    def self.find_dept
      binding.pry
      #response =  RestClient.get URL, {params:{query_courses=>"x"}, content_type: :json, accept: :json}
#:params=>RestClient::ParamsArray.new([[query_courses]])
      #need put query explicit in url becault RestClient will use encode_query_string and remove / character
      response =  RestClient.get "#{URL}?#{query_courses}", {params:{}, content_type: :json, accept: :json}
      JSON.parse(response.body)
    end

    def self.find_courses dept
      binding.pry
      response = RestClient.get "#{URL}/#{query_courses}/#{dept}", {params:{}, content_type: :json, accept: :json}
      JSON.parse(response.body)
    end

    def self.query_courses
      return "current/current"
    end
  end
end
