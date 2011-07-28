# == Schema Information
#
# Table name: computers
#
#  id         :integer(4)      not null, primary key
#  make       :string(255)
#  model      :string(255)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Computer do
  
  before(:each) do
    @user = Factory(:user)
    @attr = {
      :make  => "Apple",
      :model => "MacBook Pro"
    }
  end
  
  it "should create a new instance given valid attributes" do
    @user.computers.create!(@attr)
  end
  
  describe "user associations" do
    
    before(:each) do
      @computer = @user.computers.create!(@attr)
    end
    
    it "should have a user attribute" do
      @computer.should respond_to(:user)
    end
    
    it "should have the correct user associated" do
      @computer.user_id.should == @user.id
      @computer.user.should == @user
    end
  end
  
  describe "validations" do
    
    it "should require a user id" do
      Computer.new(@attr).should_not be_valid
    end
    
    it "should require nonblank make & model" do
      @user.computers.build(:make  => " ",
                            :model => " ").should_not be_valid
    end
    
    it "should reject long make & model" do
      @user.computers.build(:make  => "a" * 21,
                            :model => "a" * 21).should_not be_valid
    end
  end
end