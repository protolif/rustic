class TicketsController < ApplicationController
  def index
    @tickets_in_progress = Ticket.in_progress.recent.order("updated_at DESC")
    @tickets_in_queue = Ticket.in_queue.recent.order("updated_at DESC")
    @tickets_in_limbo = Ticket.in_limbo.recent.order("updated_at DESC")
  end

  def show
    @ticket = Ticket.find params[:id]
  end
end
