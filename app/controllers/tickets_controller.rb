class TicketsController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user
  
  def new
    @title  = "New Ticket"
    @ticket = @user.tickets.new
  end
  
  def create
    @ticket = @user.tickets.build(params[:ticket])
    if @ticket.save
      check_in @ticket.computer
      redirect_to @user, :flash => { :success => "Ticket successfully created." }
    else
      @title = "New Ticket"
      render 'new'
    end
  end
  
  private
    
    def check_in(computer)
      computer.checked_in = Time.now
      computer.save
    end
    
    def check_out(computer)
      computer.checked_out = Time.now
      computer.save
    end
end
