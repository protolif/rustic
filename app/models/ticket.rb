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
  
  has_many :labors,   :dependent => :destroy
  has_many :parts,    :dependent => :destroy
  has_many :payments, :dependent => :destroy

  validates :customer_id, :presence => true
  validates :computer_id, :presence => true
  validates :issue,       :presence => true, :length => { :within => 10..255 }
  
  LOCAL_SALES_TAX = 0.07
  
  def subtotal
    subtotal = Money.new(0)
    labors.each do |labor|
      subtotal += labor.price
    end
    parts.each do |part|
      subtotal += part.price
    end
    subtotal
  end
  
  def tax
    tax = Money.new(0)
    parts.each do |part|
      tax += part.price * LOCAL_SALES_TAX
    end
    tax
  end
  
  def total
    total = Money.new(0)
    total += subtotal + tax
  end
  
  def calculate
    total
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
#  subtotal      :integer(4)      default(0), not null
#  total         :integer(4)      default(0), not null
#  tax           :integer(4)      default(0), not null
#

