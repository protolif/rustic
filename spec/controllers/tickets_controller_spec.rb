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
  
  describe "GET 'show'" do
    
    describe "for signed-in users" do
      
      before(:each) do
        @ticket = Factory(:ticket)
        @customer = test_sign_in(@ticket.customer)
        get :show,  :id => @ticket.id
      end
      
      it "should be successful" do
        response.should be_success
      end
      
      it "should have the correct title" do
        response.should have_selector('title', :content => "Ticket for #{@ticket.customer.fname}'s #{@ticket.computer.model} | ID: #{@ticket.id}")
      end
      
      it "should display the correct legends" do
        response.should have_selector('legend', :content => 'Ticket')
        response.should have_selector('legend', :content => 'Customer')
        response.should have_selector('legend', :content => 'Computer')
        response.should have_selector('legend', :content => 'Issue')
        response.should have_selector('legend', :content => 'Labor')
        response.should have_selector('legend', :content => 'Parts')
        response.should have_selector('legend', :content => 'Bill')
        response.should have_selector('legend', :content => 'Payments')
        response.should have_selector('legend', :content => 'Notes')
      end
    end
    
    describe "for non-signed-in users" do
      
      it "should deny access" do
        get :show, :id => 1
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
