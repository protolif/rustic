namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:fname => "James",
                         :lname => "Dunn",
                         :email => "jamesldunnjr@gmail.com",
                         :tel => "317.656.9939",
                         :address => "6920-D Buckridge East Drive",
                         :city => "Indianapolis",
                         :state => "IN",
                         :zip => "46227",
                         :password => "pa55w0rD",
                         :password_confirmation => "pa55w0rD")
    admin.toggle!(:admin)
    admin.computers.create!(:make => 'Apple', :model => 'MacBook Pro')
    admin.computers.create!(:make => 'Apple', :model => 'PowerMac G4')
    admin.computers.create!(:make => 'Custom', :model => 'Black NZXT')
    
    manufacturers = ['Acer', 'Compaq', 'eMachines', 'Everex', 'Gateway', 'Apple',
                     'Asus', 'Dell', 'Alienware', 'Falcon Northwest', 'Fujitsu',
                     'HP', 'IBM', 'Lenovo', 'MSI', 'Panasonic', 'Samsung',
                     'Sharp', 'Shuttle', 'Sony', 'Toshiba', 'Averatec']
                     
    models = ['g73sw-bst6', 'k52f-bin6', 'vgn-n320e', 'l655-s5150', 't42', 'nx4504', 'D655',
              'a1181', 'dv7-4285dx', 'z560', '1337', 'cf-29', 'ma6', 'w350a', 'pcg-7192l',
              'p5we6', 'cq62-410us', 'ms2257', 'lm7wz', 'g7-1070us', 'cr600', 'c655d-s5120']
    
    99.times do
      fname    = Faker::Name.first_name
      lname    = Faker::Name.last_name
      email    = Faker::Internet.email("#{fname} #{lname}")
      tel      = Faker::PhoneNumber.phone_number
      address  = Faker::Address.street_address
      city     = Faker::Address.city
      state    = Faker::Address.us_state_abbr
      zip      = Faker::Address.zip_code
      password = Faker::Lorem.words(12)
      user     = User.create!(:fname   => fname,
                              :lname   => lname,
                              :email   => email,
                              :tel     => tel,
                              :address => address,
                              :city    => city,
                              :state   => state,
                              :zip     => zip,
                              :password              => password,
                              :password_confirmation => password)
      3.times do
       user.computers.create!(:make => manufacturers.rand, :model => models.rand)
      end
    end
  end
end
