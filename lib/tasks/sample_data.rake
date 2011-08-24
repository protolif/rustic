namespace :db do
  desc "register administrative accounts"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:fname => "James",
                 :lname => "Dunn",
                 :email => "jamesldunnjr@gmail.com",
                 :tel => "317.656.9939",
                 :address => "6920-D Buckridge East Drive",
                 :city => "Indianapolis",
                 :state => "IN",
                 :zip => "46227",
                 :password => "pa55w0rD",
                 :password_confirmation => "pa55w0rD").toggle!(:admin)

    User.create!(:fname => "James",
                 :lname => "Cole",
                 :email => "rat3dk@gmail.com",
                 :tel => "317.334.1850",
                 :address => "8403 N Michigan Rd",
                 :city => "Indianapolis",
                 :state => "IN",
                 :zip => "46268",
                 :password => "pa55w0rD",
                 :password_confirmation => "pa55w0rD").toggle!(:admin)

     User.create!(:fname => "Ed",
                  :lname => "Dischinger",
                  :email => "ead46254@gmail.com",
                  :tel => "317.334.1850",
                  :address => "8403 N Michigan Rd",
                  :city => "Indianapolis",
                  :state => "IN",
                  :zip => "46268",
                  :password => "pa55w0rD",
                  :password_confirmation => "pa55w0rD").toggle!(:admin)

    User.create!(:fname => "Glenn",
                 :lname => "Nopal",
                 :email => "gnopal4612@gmail.com",
                 :tel => "317.334.1850",
                 :address => "8403 N Michigan Rd",
                 :city => "Indianapolis",
                 :state => "IN",
                 :zip => "46268",
                 :password => "pa55w0rD",
                 :password_confirmation => "pa55w0rD").toggle!(:admin)
  end
end
