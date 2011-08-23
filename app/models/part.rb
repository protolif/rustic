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
