class UsersController < ApplicationController
  before_filter :authenticate,     :only => [:show, :edit, :update, :index, :destroy]
  before_filter :correct_user,     :only => [:edit, :update]
  before_filter :admin_user,       :only => [:destroy]
  before_filter :session_killer,   :only => [:new, :create]
  
  def index
    @title = "All Users"
    @users = User.search(params[:search], params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @title = "#{@user.fname} #{@user.lname}"
  end
  
  def new
    @user = User.new
    @title = 'Sign up'
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to @user, :flash => { :success => "Success! Welcome to CSC." }
    else
      @title = 'Sign up'
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, :flash => { :success => "Profile updated." }
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    @user.destroy
    redirect_to users_path, :flash => { :success => "User destroyed." }
  end

  private
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) if !current_user?(@user) && !current_user.admin?
    end
    
    def session_killer
      sign_out unless current_user.nil?
    end
end