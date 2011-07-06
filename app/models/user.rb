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
  
  private
  
    def encrypt_password
      self.encrypted_password = encrypt(self.password)
    end
    
    def encrypt(string)
      string # This is not finished yet. For test/dev purposes only. Worst encryption ever.
    end
  
end
