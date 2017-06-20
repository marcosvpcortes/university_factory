require_relative "sfu_api"

module University
  class Program < ApplicationRecord

    def self.create_from_api
      University::SFUApi.find_dept
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
