# == Schema Information
#
# Table name: computers
#
#  id         :integer(4)      not null, primary key
#  make       :string(255)
#  model      :string(255)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  serial     :string(255)
#
class Computer < ActiveRecord::Base
  attr_accessible :make, :model, :serial
  
  belongs_to :user
  
  validates :make,    :presence => true, :length => { :maximum => 20 }
  validates :model,   :presence => true, :length => { :maximum => 20 }
  validates :user_id, :presence => true
  validates :serial,  :presence => true
  
  default_scope :order => 'computers.created_at DESC'
end


