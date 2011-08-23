require 'spec_helper'

describe PaymentsController do
  render_views
  
  describe "POST 'create'" do
    
    describe "success" do
      
      before(:each) do
        @user     = test_sign_in(Factory(:user))
        @computer = Factory(:computer, :user => @user)
        @ticket   = Factory(:ticket, :computer => @computer)
        @attr     = { :method    => "MasterCard",
                      :amount    => "$19.99",
                      :ticket_id => @ticket.id }
      end
      
      it "should create a payment" do
        lambda do
          post :create, :payment => @attr
        end.should change(Payment, :count).by(1)
      end
      
      it "should create a payment using Ajax" do
        lambda do
          xhr :post, :create, :payment => @attr
          response.should be_success
        end.should change(Payment, :count).by(1)
      end
    end
  end
  
  describe "DELETE 'destroy'" do

    before(:each) do
      @user     = test_sign_in(Factory(:user))
      @computer = Factory(:computer, :user => @user)
      @ticket   = Factory(:ticket, :computer => @computer)
      @attr     = { :method    => "MasterCard",
                    :amount    => "$19.99",
                    :ticket_id => @ticket.id }
      @payment  = @ticket.payments.create!(@attr)
    end
    
    it "should destroy a labor" do
      lambda do
        delete :destroy, :id => @payment
      end.should change(Payment, :count).by(-1)
    end
    
    it "should destroy a labor using Ajax" do
      lambda do
        xhr :delete, :destroy, :id => @payment.id
        #response.should be_success
      end.should change(Payment, :count).by(-1)
    end
  end
end