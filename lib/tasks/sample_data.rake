namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:fname => "James",
                         :lname => "Dunn",
                         :email => "jamesldunnjr@gmail.com",
                         :tel => "317.656.9939",
                         :password => "pa55w0rD",
                         :password_confirmation => "pa55w0rD")
    admin.toggle!(:admin)
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
