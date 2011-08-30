require 'spec_helper'

describe Payment do
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
        Payment.new(:price  => "$19.99",
                    :method => "MasterCard").should_not be_valid
      end
      
      it "should require a non-blank method" do
        @ticket.payments.build(:method => " " * 10,
                               :price  => "$19.99").should_not be_valid
      end
    end
    
    describe "success" do
      
      it "should create a payment given valid attributes" do
        @ticket.payments.build(:method => "MasterCard",
                               :price  => "$19.99").should be_valid
      end
    end
  end
end


# == Schema Information
#
# Table name: payments
#
#  id         :integer(4)      not null, primary key
#  ticket_id  :integer(4)
#  price      :integer(4)      default(0), not null
#  method     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

