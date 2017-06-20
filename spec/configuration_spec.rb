require './config/initializers/libs.rb'
require './config/initializers/dependencies.rb'
require './config/initializers/dependencies_test.rb'


RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before :suite do
    ENV["RAILS_ENV"] = "test"
    Rake::load_rakefile "./Rakefile"
    Rake::Task["db:migrate"].invoke

    #init factorygirl
    FactoryGirl.find_definitions

    #create program
    FactoryGirl.create(:program)
  end

  config.after :suite do
    #Rake:Task["db:drop"].invoke
  end
end
