class Computer < ActiveRecord::Base
  attr_accessible :make, :model, :serial, :form_factor, :location,
                  :charger, :cpu, :ram, :checked_in, :checked_out
  
  belongs_to :user
  
  validates :make,    :presence => true, :length => { :maximum => 20 }
  validates :model,   :presence => true, :length => { :maximum => 20 }
  validates :user_id, :presence => true
  validates :serial,  :presence => true
  
  default_scope :order => 'computers.created_at DESC'
  
  FF = ['Netbook', 'Laptop', 'Desktop Replacement', 'Shuttle', 
        'SFF', 'Mini-Tower', 'Mid-Tower', 'Full-Tower',
        '1U-Server', '2U-Server', '3U-Server', '4U-Server']
        
  MAKES = ['Acer', 'Alienware', 'Apple', 'Asus', 'Averatec', 'Compaq', 
           'Custom', 'Dell', 'eMachines', 'Everex', 'Falcon Northwest',
           'Fujitsu', 'Gateway', 'HP', 'IBM', 'Lenovo', 'MSI', 'Other',
           'Panasonic', 'Samsung', 'Sharp', 'Shuttle', 'Sony', 'Toshiba']
  
  ZONES = ['Triage', 'Front Desk', 'Island', "James' Desk",
           "Ed's Desk", "Glenn's Desk", 'Shelf A', 'Shelf B',
           'Shelf C', 'Shelf D', 'Shelf E', 'Shelf F',
           'Shelf L', 'Soldering Station']
end

# == Schema Information
#
# Table name: computers
#
#  id          :integer(4)      not null, primary key
#  make        :string(255)
#  model       :string(255)
#  user_id     :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#  serial      :string(255)
#  charger     :boolean(1)
#  cpu         :string(255)
#  ram         :string(255)
#  checked_in  :datetime
#  checked_out :datetime
#  form_factor :string(255)
#

