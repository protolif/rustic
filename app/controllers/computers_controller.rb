class ComputersController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :select_computer, :only => [:edit, :update, :destroy]
  before_filter :generate_qr, :only => [:show]
  
  require 'rqrcode'
  
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
  
  def show
    
  end
  
  def edit
    if @computer
      @title = "#{@computer.make} #{@computer.model}"
    else
      redirect_to user_path(@user)
    end
  end
  
  def update
    if !params[:status].nil? && params[:status] == "Closed"
      params[:computer][:checked_out] = Time.now
    end
    if @computer && @computer.update_attributes(params[:computer])
      respond_to do |format|
        format.html { redirect_to @computer, :flash => { :success => "Update Success" } }
        format.js
      end
    else
      if @computer
        @title = "#{@computer.make} #{@computer.model}"
        render 'edit'
      else #there is no computer
        respond_to do |format|
          format.html { redirect_to @user }
          format.js
        end
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
    
    def generate_qr
      @computer = Computer.find(params[:id])
      @qr = RQRCode::QRCode.new("cscindy.com/computers/#{@computer.id}")
    end
    
    def select_computer
      @computer = (@user.nil?) ? Computer.find(params[:id]) : @user.computers.find_by_id(params[:id])
    end
end
