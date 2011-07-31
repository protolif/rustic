require 'spec_helper'

describe ComputersController do
  render_views
  
  describe "GET 'new'" do
    
    describe "for signed-in users" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
        get :new, {:user_id => @user.id}
      end
      
      it "should be successful" do
        response.should be_success
      end
      
      it "should have the correct title" do
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
    
    describe "for signed-in users" do
      
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
            post :create, :computer => @attr, :user_id => @user.id
          end.should_not change(Computer, :count)
        end

        it "should redirect to the user show page" do
          post :create, :computer => @attr, :user_id => @user.id
          response.should redirect_to(user_path(@user))
        end

        it "should display a flash error message" do
          post :create, :computer => @attr, :user_id => @user.id
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
            post :create, :computer => @attr, :user_id => @user.id
          end.should change(Computer, :count).by(1)
        end

        it "should redirect to the user show page" do
          post :create, :computer => @attr, :user_id => @user.id
          response.should redirect_to(user_path(@user))
        end

        it "should display a flash message" do
          post :create, :computer => @attr, :user_id => @user.id
          flash[:success].should =~ /successfully saved/i
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
  
  describe "DELETE 'destroy'" do
    
    describe "for signed-in users" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @computer = Factory(:computer, :user => @user)
      end
      
      it "should delete the computer" do
        lambda do
          delete :destroy, :id => @computer, :user_id => @user.id
        end.should change(Computer, :count).by(-1)
        flash[:success].should =~ /successfully destroyed/i
      end
    end
    
    describe "for non-signed-in users" do
      
      it "should deny access" do
        delete :destroy, :id => 1
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end
  end
end
