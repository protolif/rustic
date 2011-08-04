require 'spec_helper'

describe UsersController do
  render_views
  
  describe "GET 'index'" do
    
    describe "for non-signed-in users" do
      
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end
    
    describe "for signed-in users" do
      
      before(:each) do
        @users = [test_sign_in(Factory(:user))]
        30.times do
          @users << Factory(:user, :email => Factory.next(:email))
        end
      end
      
      it "should be successful" do
        get :index
        response.should be_success
      end
      
      it "should have the correct title" do
        get :index
        response.should have_selector('title', :content => "All Users")
      end
      
      it "should have an element for each user" do
        get :index
        @users[0..2].each do |user|
          response.should have_selector('li', :content => "#{user.lname}, #{user.fname}")
        end
      end
      
      it "should paginate users" do
        get :index
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/users?page=2", :content => "2")
        response.should have_selector("a", :href => "/users?page=2", :content => "Next")
      end
    end
  end
  
  describe "GET 'show'" do
    
    describe "for non-signed-in users" do
      
      it "should deny access" do
        get :show, :id => Factory(:user)
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end
    
    describe "for signed-in users" do
      
      before(:each) do
        test_sign_in(@user = Factory(:user))
      end

      it "should be successful" do
        get :show, :id => @user
        response.should be_success
      end

      it "should find the right user" do
        get :show, :id => @user
        assigns(:user).should == @user
      end

      it "should have the right title" do
        get :show, :id => @user
        response.should have_selector("title", :content => "#{@user.fname} #{@user.lname}")
      end

      it "should have include the user's name" do
        get :show, :id => @user
        response.should have_selector("h1", :content => "#{@user.fname} #{@user.lname}")
      end

      it "should have a profile image" do
        get :show, :id => @user
        response.should have_selector("h1>img", :class => "gravatar")
      end

      it "should show the user's computers" do
        pc1 = Factory(:computer, :user => @user, :model => "MacBook Pro")
        pc2 = Factory(:computer, :user => @user, :model => "iMac")
        get :show, :id => @user
        response.should have_selector("tr.computer>td", :content => pc1.model)
        response.should have_selector("tr.computer>td", :content => pc2.model)
      end
    end
  end

  describe "GET 'new'" do
    
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the correct title" do
      get :new
      response.should have_selector('title', :content => "Sign up")
    end
  end
  
  describe "POST 'create'" do
    
    describe 'failure' do
      
      before(:each) do
        @attr = { :fname   => "",
                  :lname   => "",
                  :email   => "",
                  :tel     => "",
                  :address => "",
                  :city    => "",
                  :state   => "",
                  :zip     => "",
                  :password              => "",
                  :password_confirmation => ""
        }
      end
      
      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
      
      it "should have the correct title" do
        post :create, :user => @attr
        response.should have_selector('title', :content => "Sign up")
      end
      
      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end
    
    describe "success" do

      before(:each) do
        @attr = {
          :fname   => "Joseph",
          :lname   => "Khamel",
          :email   => "joseph.khamel@example.com",
          :tel     => "123.456.7890",
          :address => "123 Example Street",
          :city    => "Indianapolis",
          :state   => "IN",
          :zip     => "46268",
          :password              => "pa55w0rD",
          :password_confirmation => "pa55w0rD"
          }
      end
      
      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      
      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      
      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /success! welcome to csc./i
      end
      
      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
    end
  end
  
  describe "GET 'edit'" do
    
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
    
    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end
    
    it "should have the correct title" do
      get :edit, :id => @user
      response.should have_selector("title", :content => "Edit user")
    end
    
    it "should have a link to change the Gravatar" do
      get :edit, :id => @user
      gravatar_url = "http://gravatar.com/emails"
      response.should have_selector("a", :href => gravatar_url, :content => "Change Avatar")
    end
  end
  
  describe "PUT 'update'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "failure" do

      before(:each) do
        @attr = {
          :fname   => "",
          :lname   => "",
          :email   => "",
          :tel     => "",
          :address => "",
          :city    => "",
          :state   => "",
          :zip     => "",
          :password              => "",
          :password_confirmation => ""
          }
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end
      
      it "should have the right title" do
        put :update, :id => @user, :user => @attr
        response.should have_selector("title", :content => "Edit user")
      end
    end
    
    describe "success" do
      
      before(:each) do
        @attr = {
          :fname   => "Joseph",
          :lname   => "Khamel",
          :email   => "joseph.khamel@example.com",
          :tel     => "123.456.7890",
          :address => "123 Example Street",
          :city    => "Indianapolis",
          :state   => "IN",
          :zip     => "46268"
          }
      end
      
      it "should change the user's attributes" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.fname.should == @attr[:fname]
        @user.lname.should == @attr[:lname]
        @user.email.should == @attr[:email]
      end
      
      it "should redirect to the user show page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end
      
      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /updated/
      end
      
      it "should enforce complex password requirements" do
        @attr = { :password              => "password",
                  :password_confirmation => "password" }
        put :update, :id => @user, :user => @attr
        response.should have_selector("div#error_explanation")
      end
      
      it "should not allow blank passwords" do
         @attr = { :password              => "",
                   :password_confirmation => "" }
         put :update, :id => @user, :user => @attr
         response.should have_selector("div#error_explanation")
      end
    end
  end

  describe "authentication of edit/update pages" do

    before(:each) do
      @user = Factory(:user)
    end
    
    describe "for non-signed-in users" do
      
      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
      end
    
      it "should deny access to 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for signed-in users" do

      before(:each) do
        wrong_user = Factory(:user, :email => "user@example.net")
        test_sign_in(wrong_user)
      end

      it "should require matching users for 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end

      it "should require matching users for 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(root_path)
      end
    end
  end

  describe "DELETE 'destroy'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => @user
        response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do
      
      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @user
        response.should redirect_to(root_path)
      end
    end
    
    describe "as an admin user" do
      
      before(:each) do
        @admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(@admin)
      end

      it "should destroy the user" do
        lambda do
          delete :destroy, :id => @user
        end.should change(User, :count).by(-1)
      end
      
      it "should redirect to the users page" do
        delete :destroy, :id => @user
        response.should redirect_to(users_path)
      end
      
      it "should not allow the user to self-destruct" do
        lambda do
          delete :destroy, :id => @admin
        end.should_not change(User, :count)
      end
    end
  end
end
