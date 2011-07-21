namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    99.times do |n|
      fname = Faker::Name.first_name
      lname = Faker::Name.last_name
      email = Faker::Internet.email("#{fname} #{lname}")
      tel = Faker::PhoneNumber.phone_number
      password  = Faker::Lorem.words(12)
      User.create!(:fname => fname,
                   :lname => lname,
                   :email => email,
                   :tel => tel,
                   :password => password,
                   :password_confirmation => password)
    end
  end
end
