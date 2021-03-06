require 'spec_helper'

describe ComputersController do
  render_views
  
  describe "GET 'new'" do
    
    describe "for signed-in users" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
        get :new, :user_id => @user.id
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
  
  describe "GET 'show'" do
    
    describe "for signed-in users" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @computer = Factory(:computer, :user => @user)
        get :show, :id => @computer
      end
      
      it "should be successful" do
        response.should be_success
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
  
  describe "GET 'edit'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @computer = Factory(:computer, :user => @user)
    end
    
    it "should be successful" do
      get :edit, :id => @computer, :user_id => @user.id
      response.should be_success
    end
    
    it "should have the correct title" do
      get :edit, :id => @computer, :user_id => @user.id
      response.should have_selector('title', :content => "#{@computer.make} #{@computer.model}")
    end
  end
  
  describe "PUT 'update'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @computer = Factory(:computer, :user => @user)
    end
    
    describe "failure" do
      
      before(:each) do
        @attr = { :make   => "",
                  :model  => "",
                  :serial => "" }
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @computer, :computer => @attr, :user_id => @user.id
        response.should render_template('edit')
      end
    end
    
    describe "success" do
      
     before(:each) do
        @attr = { :make   => "Apple",
                  :model  => "MacBook Pro",
                  :serial => SecureRandom.hex(10) }
      end
      
      it "should change the computer's attributes" do
        put :update, :id => @computer, :computer => @attr, :user_id => @user.id
        @computer.reload
        @computer.make.should    == @attr[:make]
        @computer.model.should   == @attr[:model]
        @computer.serial.should  == @attr[:serial]
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
  
  describe "security model" do
    
    describe "admins acting on behalf of users" do

      before(:each) do
        @user     = test_sign_in(Factory(:user))
        @user_pc  = Factory(:computer, :user => @user)
        @admin    = test_sign_in(Factory(:user, :email => "joe.admin@example.com"))
        @admin.toggle!(:admin)
      end

      describe "POST 'create'" do

        it "should be able to create computers for them" do
          @attr = { :make   => "Dell",
                    :model  => "D600",
                    :serial => SecureRandom.hex(10) }
          lambda do          
            post :create, :computer => @attr, :user_id => @user.id
          end.should change(Computer, :count).by(1)
        end
      end
      
      describe "PUT 'update'" do
                  
        it "should update the computer's attributes for them" do
          @attr = { :make   => "Apple",
                    :model  => "MacBook Pro",
                    :serial => SecureRandom.hex(10) }
                    
          put :update, :id => @user_pc, :computer => @attr, :user_id => @user.id
          @user_pc.reload
          @user_pc.make.should    == @attr[:make]
          @user_pc.model.should   == @attr[:model]
          @user_pc.serial.should  == @attr[:serial]
        end
      end
      
      describe "DELETE 'destroy'" do

        it "should be able to destroy computers for them" do
          lambda do
            delete :destroy, :id => @user_pc, :user_id => @user.id
          end.should change(Computer, :count).by(-1)
          flash[:success].should =~ /successfully destroyed/i
        end
      end
    end

    describe "users attempting to act on behalf of users" do

      before(:each) do
        @john = test_sign_in(Factory(:user))
        @john_pc  = Factory(:computer, :user => @john)
        @jane = test_sign_in(Factory(:user, :email => "jane@example.com"))
      end

      describe "POST 'create'" do

        it "creates a computer for themselves, as hopefully intended" do
          @attr = { :make   => "Dell",
                    :model  => "D600",
                    :serial => SecureRandom.hex(10) }
          lambda do
            lambda do          
              post :create, :computer => @attr, :user_id => @john.id
            end.should_not change(@john.computers, :count)
          end.should change(@jane.computers, :count).by(1)
        end
      end
      
      describe "PUT 'update'" do
                  
        it "should NOT update the computer's attributes" do
          @attr = { :make   => "Fujitsu",
                    :model  => "Lifebook",
                    :serial => SecureRandom.hex(10) }
                    
          put :update, :id => @john_pc, :computer => @attr, :user_id => @john.id
          @john_pc.reload
          @john_pc.make.should_not   == @attr[:make]
          @john_pc.model.should_not  == @attr[:model]
          @john_pc.serial.should_not == @attr[:serial]
        end
      end
      
      describe "DELETE 'destroy'" do

        it "should NOT destroy any computers" do
          lambda do
            delete :destroy, :id => @john_pc, :user_id => @john.id
          end.should_not change(Computer, :count)
        end
      end
    end
  end
end
