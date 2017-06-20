require './config/initializers/libs.rb'
require './config/initializers/dependencies.rb'
require './config/initializers/dependencies_test.rb'

#define enviromnent
ENV['RAILS_ENV'] = 'test'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before :suite do
    Rake::load_rakefile "./Rakefile"
    Rake::Task["db:migrate"].invoke

    #init factorygirl
    FactoryGirl.find_definitions

    #create program
    FactoryGirl.create(:program)

    # Print the 10 slowest examples and example groups at the end of the spec
    # run, to help surface which specs are running particularly slow.
    #config.profile_examples = 10

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = :random

  end

  config.after :suite do
    #Rake:Task["db:drop"].invoke
  end
end
