require_relative "sfu_api"

module University
  class Program < ApplicationRecord
    
    @@sfu_api = University::SFUApi

    def self.set_sfu_api api
      @@sfu_api = api
    end

    def self.create_from_api
      @@sfu_api.find_dept
            .map{|dept|
                  p = Program.new(name:(dept["name"]||dept["text"]), code:dept["text"])
                  puts p.inspect
                  p
                }
            .each{|program| 
                  program.save
                  program
                 }
    end

    def self.random
      Program.offset(rand(Program.count)).first
    end
  end
end
