require 'spec_helper'

describe Part do
  
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
        Part.new(:item     => "4GB Flash Drive",
                 :price    => "$19.99",
                 :qty      => "1",
                 :warranty => "6 Months").should_not be_valid
      end
      
      it "should require a non-blank service" do
        @ticket.parts.build(:item     => " " * 10,
                            :price    => "$19.99",
                            :qty      => "1",
                            :warranty => "6 Months").should_not be_valid
      end
    end
    
    describe "success" do
      
      it "should create a labor given valid attributes" do
        @ticket.parts.build(:item     => "4GB Flash Drive",
                            :price    => "$19.99",
                            :qty      => "1",
                            :warranty => "6 Months").should be_valid
      end
    end
  end
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

