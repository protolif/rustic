class Part < ActiveRecord::Base
  attr_accessible :item, :price, :qty, :warranty
  
  composed_of :price,
              :class_name => 'Money',
              :mapping => %w(price cents),
              :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : Money.empty }
    
  belongs_to :ticket
  
  validates :ticket_id, :presence => true
  validates :item,      :presence => true
  validates :price,     :presence => true
  validates :qty,       :presence => true
  validates :warranty,  :presence => true
  
  WARRANTIES = ['1 Year', '6 Months', '90 Days', '30 Days', '2 Weeks', 'None']
end

# == Schema Information
#
# Table name: parts
#
#  id         :integer(4)      not null, primary key
#  item       :string(255)
#  ticket_id  :integer(4)
#  price      :integer(4)      default(0), not null
#  qty        :integer(4)      default(1), not null
#  warranty   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

