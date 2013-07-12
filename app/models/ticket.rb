class Ticket < ActiveRecord::Base  
  belongs_to :computer
  belongs_to :customer,   :class_name => "User"
  belongs_to :technician, :class_name => "User"
  
  has_many :labors,   :dependent => :destroy
  has_many :parts,    :dependent => :destroy
  has_many :payments, :dependent => :destroy

  validates :customer_id, :presence => true
  validates :computer_id, :presence => true
  validates :issue,       :presence => true, :length => { :within => 10..255 }
  
  STATUSES = ['In Queue', 'Diagnosing', 'Fixing', 'Waiting', 'Completed', 'Closed']
  
  LOCAL_SALES_TAX = 0.07
  
  scope :in_queue, where("status = ?",  "In Queue")
  scope :waiting,  where("status = ?",  "Waiting")
  scope :closed,   where("status = ?",  "Closed")
  scope :open,     where("status != ?", "Closed")
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
#  subtotal      :integer(4)      default(0), not null
#  total         :integer(4)      default(0), not null
#  tax           :integer(4)      default(0), not null
#

