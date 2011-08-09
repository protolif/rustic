require 'spec_helper'

describe Ticket do
  
  before(:each) do
    @user = Factory(:user)
    @technician = Factory(:user, :email => "admin@example.org")
    @computer = Factory(:computer, :user => @user)
  end
  
  describe "user associations" do
    
    before(:each) do
      @ticket = @user.tickets.create!(:computer_id   => @computer.id,
                                      :technician_id => @technician.id,
                                      :issue => "a" * 10)
    end
    
    it "should have a customer attribute" do
      @ticket.should respond_to(:customer)
    end
    
    it "should have a computer attribute" do
      @ticket.should respond_to(:computer)
    end
    
    it "should have a technician attribute" do
      @ticket.should respond_to(:technician)
    end
    
    it "should have the correct customer associated" do
      @ticket.customer_id.should == @user.id
      @ticket.customer.should    == @user
    end
    
    it "should have the correct computer associated" do
      @ticket.computer_id.should == @computer.id
      @ticket.computer.should    == @computer
    end
    
    it "should have the correct technician associated" do
      @ticket.technician_id.should == @technician.id
      @ticket.technician.should    == @technician
    end
  end
  
  describe "validation" do
    
    describe "failure" do
      
      it "should require a customer id" do
        Ticket.new(:computer_id => @computer.id,
                   :issue       => "a" * 10).should_not be_valid
      end

      it "should require a computer id" do
        @user.tickets.build(:issue => "a" * 10).should_not be_valid
      end

      it "should require a non-blank issue" do
        @user.tickets.build(:computer_id => @computer.id,
                            :issue       => " " * 10).should_not be_valid
      end

      it "should reject long-winded issues" do
        @user.tickets.build(:computer_id => @computer.id,
                            :issue       => "a" * 256).should_not be_valid
      end
    end
    
    describe "success" do
      
      it "should create a ticket given valid attributes" do
        @user.tickets.build(:computer_id => @computer.id,
                            :issue       => "a" * 255).should be_valid
      end
    end
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
#

