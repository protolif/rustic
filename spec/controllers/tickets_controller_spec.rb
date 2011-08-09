require 'spec_helper'

describe TicketsController do
  render_views

  describe "GET 'new'" do
    
    describe "for signed-in users" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @computer = Factory(:computer, :user => @user)
        get :new, :user_id => @user.id, :computer_id => @computer.id
      end
      
      it "should be successful" do
        response.should be_success
      end
      
      it "should have the correct title" do
        response.should have_selector('title', :content => "New Ticket")
      end
    end
    
    describe "for non-signed-in users" do
      
      it "should deny access" do
        get :new
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end
  end
  
  describe "POST 'create'" do
    
    describe "for signed-in users" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @computer = Factory(:computer, :user => @user)
        @attr = { :customer_id => @user.id,
                  :computer_id => @computer.id,
                  :issue       => "it's broken." }
      end
      
      describe "success" do
        
        it "should create a ticket" do
          lambda do
            post :create, :ticket => @attr
          end.should change(Ticket, :count).by(1)
        end
        
        it "should display a flash message" do
          post :create, :ticket => @attr
          flash[:success].should =~ /successfully created/i
        end
      end
    end
    
    describe "for non-signed-in users" do
      
      it "should deny access" do
        post :create
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end
  end
end
