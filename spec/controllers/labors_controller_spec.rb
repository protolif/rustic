require 'spec_helper'

describe LaborsController do
  render_views
  
  describe "POST 'create'" do
    
    describe "success" do
      
      before(:each) do
        @user     = test_sign_in(Factory(:user))
        @computer = Factory(:computer, :user => @user)
        @ticket   = Factory(:ticket, :computer => @computer)
        @attr     = { :service   => "foo",
                      :price     => "$1",
                      :notes     => "bar",
                      :ticket_id => @ticket.id }
      end
      
      it "should create a labor" do
        lambda do
          post :create, :labor => @attr
        end.should change(Labor, :count).by(1)
      end
      
      it "should create a relationship using Ajax" do
        lambda do
          xhr :post, :create, :labor => @attr
          response.should be_success
        end.should change(Labor, :count).by(1)
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    
  end
end
