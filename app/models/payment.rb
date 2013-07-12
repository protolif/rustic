class Payment < ActiveRecord::Base    
  belongs_to :ticket
  
  validates :ticket_id, :presence => true
  validates :price,     :presence => true
  validates :method,    :presence => true
  
  METHODS = ['Cash', 'Check', 'Visa', 'MasterCard', 'Amex', 'Discover']
end

# == Schema Information
#
# Table name: payments
#
#  id         :integer(4)      not null, primary key
#  ticket_id  :integer(4)
#  amount     :integer(4)      default(0), not null
#  method     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

