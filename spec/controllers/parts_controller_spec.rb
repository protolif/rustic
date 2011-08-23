require 'spec_helper'

describe PartsController do
  render_views
  
  describe "POST 'create'" do
    
    describe "success" do
      
      before(:each) do
        @user     = test_sign_in(Factory(:user))
        @computer = Factory(:computer, :user => @user)
        @ticket   = Factory(:ticket, :computer => @computer)
        @attr     = { :item      => "4GB Flash Drive",
                      :price     => "$19.99",
                      :qty       => 1,
                      :warranty  => "6 Months",
                      :ticket_id => @ticket.id }
      end
      
      it "should create a part" do
        lambda do
          post :create, :part => @attr
        end.should change(Part, :count).by(1)
      end
      
      it "should create a part using Ajax" do
        lambda do
          xhr :post, :create, :part => @attr
          response.should be_success
        end.should change(Part, :count).by(1)
      end
    end
  end
  
  describe "DELETE 'destroy'" do

    before(:each) do
      @user     = test_sign_in(Factory(:user))
      @computer = Factory(:computer, :user => @user)
      @ticket   = Factory(:ticket, :computer => @computer)
      @attr     = { :item      => "4GB Flash Drive",
                    :price     => "$19.99",
                    :qty       => 1,
                    :warranty  => "6 Months",
                    :ticket_id => @ticket.id }
      @part     = @ticket.parts.create!(@attr)
    end
    
    it "should destroy a labor" do
      lambda do
        delete :destroy, :id => @part
      end.should change(Part, :count).by(-1)
    end
    
    it "should destroy a labor using Ajax" do
      lambda do
        xhr :delete, :destroy, :id => @part.id
        #response.should be_success
      end.should change(Part, :count).by(-1)
    end
  end
end
