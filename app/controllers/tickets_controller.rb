class TicketsController < ApplicationController
  def index
    @tickets_in_progress = Ticket.in_progress.recent.order("updated_at DESC")
    @tickets_in_queue = Ticket.in_queue.recent.order("updated_at DESC")
    @tickets_in_limbo = Ticket.in_limbo.recent.order("updated_at DESC")
  end

  def show
    @ticket = Ticket.find params[:id]
  end

  def archive
    @tickets_in_archive = Ticket.archived.order("updated_at DESC").paginate(page: params[:page], per_page: 30)
  end
end
