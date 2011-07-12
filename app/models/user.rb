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
require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :fname, :lname, :email, :tel, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :fname, :presence =>  true, :length => { :maximum => 20 }
  validates :lname, :presence =>  true, :length => { :maximum => 20 }
  validates :tel,   :presence =>  true, :length => { :maximum => 12 }
  validates :email, :presence =>  true,
                    :format   =>  { :with => email_regex},
                    :uniqueness => { :case_sensitive => false }
                    
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 8..20 }

  before_save :encrypt_password
  
  #begin class methods
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    (user && user.has_password?(submitted_password)) ? user : nil
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  private #begin private methods
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def encrypt_password #really works now ^_^
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
  #end private methods
  #end class methods
end
