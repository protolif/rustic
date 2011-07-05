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
  attr_accessible :fname, :lname, :email, :tel
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :fname, :presence =>  true, :length => { :maximum => 20 }
  validates :lname, :presence =>  true, :length => { :maximum => 20 }
  validates :tel,   :presence =>  true, :length => { :maximum => 12 }
  validates :email, :presence =>  true, :format => { :with => email_regex},
                    :uniqueness => { :case_sensitive => false }
end
