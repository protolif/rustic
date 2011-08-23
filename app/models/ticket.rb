class Ticket < ActiveRecord::Base
  attr_accessible :customer_id, :computer_id, :technician_id, :issue, :status,
                  :subtotal, :total, :tax
  
  composed_of :subtotal,
              :class_name => 'Money',
              :mapping => %w(price cents),
              :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : Money.empty }
  
  composed_of :total,
              :class_name => 'Money',
              :mapping => %w(price cents),
              :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : Money.empty }
  
  composed_of :tax,
              :class_name => 'Money',
              :mapping => %w(price cents),
              :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : Money.empty }
  
  belongs_to :computer
  belongs_to :customer,   :class_name => "User"
  belongs_to :technician, :class_name => "User"
  
  has_many :labors, :dependent => :destroy

  validates :customer_id, :presence => true
  validates :computer_id, :presence => true
  validates :issue,       :presence => true, :length => { :within => 10..255 }
  
  def subtotal
    subtotal = Money.new(0)
    labors.each do |labor|
      subtotal += labor.price
    end
    subtotal
  end
  
  def calculate
    subtotal
  end
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

