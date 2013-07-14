class TicketsController < ApplicationController
  def index
    @tickets = Ticket.open.recent.order("updated_at DESC")
  end

  def show
    @ticket = Ticket.find params[:id]
  end
end
