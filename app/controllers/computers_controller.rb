class ComputersController < ApplicationController
  before_filter :authenticate
  
  def new
    @title = "New Computer"
    @computer = current_user.computers.new
  end
  
  def create
    @computer = current_user.computers.build(params[:computer])
    if @computer.save
      flash[:success] = "Computer successfully saved."
    else
      flash[:error] = "Unable to save computer."
    end
    redirect_to user_path(current_user)
  end
end
