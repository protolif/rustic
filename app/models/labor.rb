class Labor < ActiveRecord::Base
  attr_accessible :service, :price, :notes
  
  composed_of :price,
              :class_name => 'Money',
              :mapping => %w(price cents),
              :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : Money.empty }
    
  belongs_to :ticket
  
  validates :ticket_id, :presence => true
  validates :service,   :presence => true
  
  SERVICES = ['Console Repair',
              'Data Recovery',
              'Diagnosis',
              'Laptop Disassembly',
              'Minimum Labor',
              'Premium Service',
              'Tune-up',
              'Virus Removal',
              'Wipe & Reload']
end

# == Schema Information
#
# Table name: labors
#
#  id         :integer(4)      not null, primary key
#  service    :string(255)
#  price      :integer(4)      default(0), not null
#  notes      :string(255)
#  ticket_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

