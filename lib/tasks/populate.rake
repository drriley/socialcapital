namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    
    # Invoke rake db:migrate just in case...
    Rake::Task['db:migrate'].invoke
    
    # Need two gems to make this work: faker & populator
    # Docs at: http://populator.rubyforge.org/
    require 'populator'
    require 'faker'

    [Member].each(&:delete_all)
  
    30.times {
            member = Member.new
            member.first_name = Faker::Name.first_name
            member.last_name = Faker::Name.last_name
            member.price = rand(1..30)
            member.caps = rand(1..500)
            member.save!
        }
    
  end
end