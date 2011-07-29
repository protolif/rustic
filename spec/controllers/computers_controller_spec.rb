require 'spec_helper'

describe ComputersController do
  render_views
  
  describe "GET 'new'" do
    
    describe "for signed-in users" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
      end
      
      it "should be successful" do
        get :new
        response.should be_success
      end
      
      it "should have the correct title" do
        get :new
        response.should have_selector('title', :content => "New Computer")
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
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    
    describe "failure" do
      
      before(:each) do
        @attr = { :make   => "",
                  :model  => "",
                  :serial => "" }
      end
      
      it "should not create a computer" do
        lambda do          
          post :create, :computer => @attr
        end.should_not change(Computer, :count)
      end
      
      it "should redirect to the user show page" do
        post :create, :computer => @attr
        response.should redirect_to(user_path(@user))
      end
      
      it "should display a flash error message" do
        post :create, :computer => @attr
        flash[:error].should =~ /unable to save/i
      end
    end
    
    describe "success" do
      
      before(:each) do
        @attr = { :make   => "Apple",
                  :model  => "MacBook Pro",
                  :serial => "a10183475974" }
      end
                
      it "should create a computer" do
        lambda do          
          post :create, :computer => @attr
        end.should change(Computer, :count)
      end
      
      it "should redirect to the user show page" do
        post :create, :computer => @attr
        response.should redirect_to(user_path(@user))
      end
      
      it "should display a flash message" do
        post :create, :computer => @attr
        flash[:success].should =~ /successfully saved/i
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    it "does something"
  end
end
