class TicketsController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user
  before_filter :admin_only, :only => [:index]
  
  def index
    @title      = "Tickets"
    @tickets    = Ticket.all
    @open       = Ticket.open
    @my_jobs    = Ticket.open.where("technician_id = ?", @admin.id)
    @in_queue   = Ticket.in_queue
    @waiting    = Ticket.waiting
    @closed     = Ticket.closed
  end
  
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
  
  def show
    @ticket = Ticket.find_by_id(params[:id])
    @title  = "Ticket for #{@ticket.customer.fname}'s #{@ticket.computer.model} | ID: #{@ticket.id}"
    @customer = @ticket.customer
    @computer = @ticket.computer
    @technician = @ticket.technician
  end
  
  def update
    @ticket = Ticket.find(params[:ticket][:id])
    if @ticket.update_attributes(params[:ticket])
      check_out @ticket.computer if params[:ticket][:status] == "Closed"
      clear_technician @ticket if params[:ticket][:status] == "In Queue"
      respond_to do |format|
        format.html { redirect_to @ticket }
        format.js
      end
    end
  end
  
  private
  
    def check_in(computer)
      computer.checked_in  = Time.now
      computer.checked_out = nil
      computer.save
    end
    
    def check_out(computer)
      computer.checked_out = Time.now
      computer.save
    end
    
    def clear_technician(ticket)
      ticket.technician = nil
      ticket.save
    end
end
