require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = {
      :fname   => "Joseph",
      :lname   => "Khamel",
      :email   => "joseph.khamel@example.com",
      :tel     => "123.456.7890",
      :address => "123 Example Street",
      :city    => "Indianapolis",
      :state   => "IN",
      :zip     => "46268",
      :password              => "pa55w0rD",
      :password_confirmation => "pa55w0rD"
      }
  end

  it "should create a new instance, given valid attributes" do
    User.create!(@attr)
  end

  it "should require a first name" do
    john_khamel = User.new(@attr.merge(:fname => ""))
    john_khamel.should_not be_valid
  end

  it "should reject first names longer than 20 characters" do
    long_fname = "a" * 21
    long_fname_user = User.new(@attr.merge(:fname => long_fname))
    long_fname_user.should_not be_valid
  end

  it "should require a last name" do
    joseph_doe = User.new(@attr.merge(:lname => ""))
    joseph_doe.should_not be_valid
  end

  it "should reject last names longer than 20 characters" do
    long_lname = "a" * 21
    long_lname_user = User.new(@attr.merge(:lname => long_lname))
    long_lname_user.should_not be_valid
  end

  it "should require an email address" do
    joseph_emailess = User.new(@attr.merge(:email => ""))
    joseph_emailess.should_not be_valid
  end

  it "should accept valid email addressses" do
    valid_emails = %w[user@example.com first.last@example.com user@example.co.uk
                   user+ebay@example.com flast123@email.uni-name.edu]
    valid_emails.each do | good_email |
      valid_email_user = User.new(@attr.merge(:email => good_email))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addressses" do
    invalid_emails = %w[user@example user@example. user@example,com
                   last,first@example.com user@company_name.com user@.com]
    invalid_emails.each do | bad_email |
      invalid_email_user = User.new(@attr.merge(:email => bad_email))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    duplicate_email_user = User.new(@attr)
    duplicate_email_user.should_not be_valid
  end

  it "should require a telephone number" do
    joe_phoneless = User.new(@attr.merge(:tel => ""))
    joe_phoneless.should_not be_valid
  end

  it "no longer requires an address" do
    joe_homeless = User.new(@attr.merge(:address => ""))
    joe_homeless.should be_valid
  end
  
  it "no longer requires a city" do
    joe_homeless = User.new(@attr.merge(:city => ""))
    joe_homeless.should be_valid
  end
  
  it "no longer requires a state" do
    joe_homeless = User.new(@attr.merge(:state => ""))
    joe_homeless.should be_valid
  end
  
  it "no longer requires a zip" do
    joe_homeless = User.new(@attr.merge(:zip => ""))
    joe_homeless.should be_valid
  end
  
  it "should reject telephone numbers longer than 22 characters" do
    long_tel = "1" * 23
    long_tel_user = User.new(@attr.merge(:tel => long_tel))
    long_tel_user.should_not be_valid
  end

  describe "password validations" do

    it "should require a password" do
      joe_passwordless = User.new(@attr.merge(:password => "", :password_confirmation => ""))
      joe_passwordless.should_not be_valid
    end

    it "should require a matching password confirmation" do
      joe_fatfingers = User.new(@attr.merge(:password_confirmation => "pashwort"))
      joe_fatfingers.should_not be_valid
    end

    it "should reject short passwords" do
      pwd = "a" * 7
      joe_laxpass = User.new(@attr.merge(:password => pwd, :password_confirmation => pwd))
      joe_laxpass.should_not be_valid
    end

    it "should reject long passwords" do
      pwd = "a" * 21
      joe_paranoid = User.new(@attr.merge(:password => pwd, :password_confirmation => pwd))
      joe_paranoid.should_not be_valid
    end
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set an encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do

      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end

    describe "authentication method" do

      it "should return nil on email/password mismatch" do
        joe_alzheimer = User.authenticate(@attr[:email], "invalid_pwd")
        joe_alzheimer.should be_nil
      end

      it "should return nil for an email address not found in the database" do
        joe_fatfingers = User.authenticate("joe@eaxmlpe.net", @attr[:password])
        joe_fatfingers.should be_nil
      end

      it "should return the user on email/password match" do
        joe_winstoday = User.authenticate(@attr[:email], @attr[:password])
        joe_winstoday.should == @user
      end
    end
  end

  describe "admin attribute" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end
    
    it "should not be an admin by default" do
      @user.should_not be_admin
    end
    
    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end
  
  describe "computer association" do
    
    before(:each) do
      @user = User.create!(@attr)
      @pc1  = Factory(:computer, :user => @user, :created_at => 1.day.ago)
      @pc2  = Factory(:computer, :user => @user, :created_at => 1.hour.ago)
    end
    
    it "should have a computer attribute" do
      @user.should respond_to(:computers)
    end
    
    it "should have the correct computers in the proper order" do
      @user.computers.should == [@pc2, @pc1]
    end
    
    it "should destroy associated computers" do
      @user.destroy
      [@pc1, @pc2].each do |computer|
        Computer.find_by_id(computer.id).should be_nil
      end
    end
  end
  
  describe "ticket association" do
    
    before(:each) do
      @user = Factory(:user)
      @technician = Factory(:user, :email => "admin@example.org")
      @computer = Factory(:computer, :user => @user)
      @ticket = @user.tickets.create!(:computer_id   => @computer.id,
                                      :technician_id => @technician.id,
                                      :issue         => "a" * 10)
    end
    
    it "user should have many tickets" do
      @user.should respond_to(:tickets)
      @user.tickets.first.should == @ticket
    end
    
    it "technicians should have many jobs" do
      @technician.should respond_to(:jobs)
      @technician.jobs.first.should == @ticket
    end
  end
end
# == Schema Information
#
# Table name: users
#
#  id                 :integer(4)      not null, primary key
#  fname              :string(255)
#  lname              :string(255)
#  email              :string(255)
#  tel                :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean(1)      default(FALSE)
#  address            :string(255)
#  city               :string(255)
#  state              :string(255)
#  zip                :string(255)
#  tel2               :string(255)
#

