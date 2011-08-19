require 'spec_helper'

describe Labor do
  
  before(:each) do
    @user = Factory(:user)
    @technician = Factory(:user, :email => "admin@example.org")
    @computer = Factory(:computer, :user => @user)
    @ticket = @user.tickets.create!(:computer_id   => @computer.id,
                                    :technician_id => @technician.id,
                                    :issue => "a" * 10)
  end
  
  describe "validation" do
    
    describe "failure" do
      
      it "should require a ticket id" do
        Labor.new(:service => "Virus Removal",
                  :price   => "$99",
                  :notes   => "1337 Malware").should_not be_valid
      end
      
      it "should require a non-blank service" do
        @ticket.labors.build(:service => " " * 10,
                             :price   => "$99").should_not be_valid
      end
    end
    
    describe "success" do
      
      it "should create a labor given valid attributes" do
        @ticket.labors.build(:service => "Virus Removal",
                             :price   => "$99",
                             :notes   => "1337 Malware").should be_valid
      end
    end
  end
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

