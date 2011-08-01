class ComputersController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user, :only => [:destroy, :create, :new]
  
  def new
    @title = "New Computer"
    @computer = @user.computers.new
  end
  
  def create
    @computer = @user.computers.build(params[:computer])
    if @computer.save
      flash[:success] = "Computer successfully saved."
    else
      flash[:error] = "Unable to save computer."
    end
    redirect_to user_path(@user)
  end
  
  def destroy
    @computer = @user.computers.find_by_id(params[:id])
    if @computer && @computer.destroy
      flash[:success] = "Computer successfully destroyed."
    else
      flash[:error] = "Error destroying computer."
    end
    redirect_to user_path(@user)
  end
  
  private
  
    def on_behalf_of(user)
      (current_user.admin?) ? user : current_user
    end
    
    def correct_user
      #if admin else current_user
      @user = on_behalf_of(User.find_by_id(params[:user_id]))
    end
end
