class ComputersController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user, :only => [:destroy]
  
  def new
    @title = "New Computer"
    @user = User.find_by_id(params[:user_id])
    @computer = @user.computers.new
  end
  
  def create
    @user = User.find_by_id(params[:user_id])
    @computer = @user.computers.build(params[:computer])
    if @computer.save
      flash[:success] = "Computer successfully saved."
    else
      flash[:error] = "Unable to save computer."
    end
    redirect_to user_path(@computer.user)
  end
  
  def destroy
    if @computer.destroy
      flash[:success] = "Computer successfully destroyed."
    else
      flash[:error] = "Error destroying computer."
    end
    redirect_back_or(user_path(@user))
  end
  
  private
    
    def correct_user
      @computer = Computer.find_by_id(params[:id])
      @user = @computer.user
      redirect_to(root_path) if !current_user?(@user) && !current_user.admin?
    end
end
