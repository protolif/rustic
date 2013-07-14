class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all limit: 20
  end

  def show
    @ticket = Ticket.find params[:id]
  end
end
