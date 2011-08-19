class Ticket < ActiveRecord::Base
  attr_accessible :customer_id, :computer_id, :technician_id, :issue, :status
  
  belongs_to :computer
  belongs_to :customer,   :class_name => "User"
  belongs_to :technician, :class_name => "User"
  
  has_many :labors, :dependent => :destroy

  validates :customer_id, :presence => true
  validates :computer_id, :presence => true
  validates :issue,       :presence => true, :length => { :within => 10..255 }
end


# == Schema Information
#
# Table name: tickets
#
#  id            :integer(4)      not null, primary key
#  customer_id   :integer(4)
#  computer_id   :integer(4)
#  technician_id :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#  issue         :string(255)
#  status        :string(255)
#

