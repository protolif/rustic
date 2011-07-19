# == Schema Information
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  fname      :string(255)
#  lname      :string(255)
#  email      :string(255)
#  tel        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = {
      :fname => "Joseph",
      :lname => "Khamel",
      :email => "joseph.khamel@example.com",
      :tel =>   "123.456.7890",
      :password => "pa55w0rD",
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
    joseph_phoneless = User.new(@attr.merge(:tel => ""))
    joseph_phoneless.should_not be_valid
  end

  it "should reject telephone numbers longer than 12 characters" do
    long_tel = "1" * 13
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
end
