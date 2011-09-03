class TicketsController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user
  before_filter :admin_only, :only => [:index]
  
  def index
    @title      = "Tickets"
    @open       = Ticket.open.order("created_at")
    @my_jobs    = Ticket.open.where("technician_id = ?", @admin.id).order("created_at")
    @in_queue   = Ticket.in_queue.order("created_at")
    @waiting    = Ticket.waiting.order("created_at")
    @closed     = Ticket.closed.order("created_at")
  end
  
  def new
    @title  = "New Ticket"
    @ticket = @user.tickets.new
    respond_to do |format|
      format.html { render 'new' }
      format.js
    end
  end
  
  def create
    @ticket = @user.tickets.build(params[:ticket])
    if @ticket.save
      check_in @ticket.computer
      respond_to do |format|
        format.html { redirect_to @user, :flash => { :success => "Ticket successfully created." } }
        format.js
      end
    else
      @title = "New Ticket"
      respond_to do |format|
        format.html { redirect_to 'new' }
        format.js
      end
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
