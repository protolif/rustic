class ComputersController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user
  before_filter :select_computer, :only => [:edit, :update, :destroy]
  
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
  
  def edit
    if @computer
      @title = "#{@computer.make} #{@computer.model}"
    else
      redirect_to user_path(@user)
    end
  end
  
  def update
    if @computer && @computer.update_attributes(params[:computer])
      redirect_to @user, :flash => { :success => "The computer was updated successfully." }
    else
      if @computer
        @title = "#{@computer.make} #{@computer.model}"
        render 'edit'
      else
        redirect_to user_path(@user)
      end
    end
  end
  
  def destroy
    if @computer && @computer.destroy
      flash[:success] = "Computer successfully destroyed."
    else
      flash[:error] = "Error destroying computer."
    end
    redirect_to user_path(@user)
  end
  
  private
    
    def select_computer
      @computer = @user.computers.find_by_id(params[:id])
    end
end
