class Labor < ActiveRecord::Base    
  belongs_to :ticket
  
  validates :ticket_id, :presence => true
  validates :service,   :presence => true
  validates :price,     :presence => true
  
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

