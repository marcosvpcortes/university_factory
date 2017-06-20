require './config/initializers/libs.rb'
require './config/initializers/dependencies.rb'

#https://gist.github.com/stevenyap/7038932
namespace :db do

  def env 
    ENV["RAILS_ENV"];
  end

  def connection_details
    @connection_details ||= YAML::load(File.open('config/database.yml'))[env]
  end

  desc "Migrate the db"
  task :migrate do
    ActiveRecord::Base.establish_connection(connection_details)
    ActiveRecord::Migrator.migrate("db/migrate/")
  end

  desc "Create the db"
  task :create do
    ActiveRecord::Base.establish_connection(connection_details)
    ActiveRecord::Base.connection.create_database(connection_details.fetch('database'))
  end

#  desc "Erase all tables"
#  task :clear do
#    #conn = ActiveRecord::Base.connection
#    ActiveRecord::Base.establish_connection(connection_details)
#    tables = ActiveRecord::Base.connection.tables
#    tables.each do |table|
#      puts "Deleting #{table}"
#      tables = ActiveRecord::Base.connection.drop_table(table)
#    end
#  end

  desc "drop the db"
  task :drop do
    ActiveRecord::Base.establish_connection(connection_details)
    ActiveRecord::Base.connection.drop_database(connection_details.fetch('database'))
  end
end


namespace :university do

  desc "test"
  task "test" do
    puts (University::LipsumApi.new ).get_lipsum 200
    #Forgery(:lorem_ipsum).paragraphs(200, {sentences:3})
  end
  desc "Build programs"
  task :build_programs do
    University::Program.create_from_api
  end

  desc "Build courses based on programs"
  task :build_courses => [:build_programs] do
    University::Course.create_from_api
  end

  desc "Build students"
  task :build_students => [:build_courses] do
    University::Student.create_from_api
  end

  desc "Build students' grades"
  task :build_grades => [:build_students] do
    University::Grade.create_for_students
  end


  desc "Build university data"
  task :build => [:build_students, :build_courses, :build_programs, :build_grades] do
    #lipsum = University::LipsumApi.new
    #(1..200).each {|i| print "Desc: " + lipsum.get_lipsum(3) }
    #ActiveRecord::Base.establish_connection(connection_details)
    #programs = University::Program.create_from_api
    #University::Course.create_from_api programs
    #University::Student.create_students_from_api
  end

end
