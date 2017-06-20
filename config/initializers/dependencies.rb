#requires the ApplicationRecord
require "./app/models/application_record.rb"
#requires models
Dir.glob("./app/models/*.rb").each{|f| require f}

