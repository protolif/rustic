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

  def update
    @ticket = Ticket.find params[:id]
    if @ticket
      if @ticket.update_attributes!(ticket_params)
        redirect_to @ticket
      else
        raise 'herp'.inspect
      end
    else
      raise 'derp'.inspect
    end
  end

  private
    def ticket_params
      params.require(:ticket).permit(:notes)
    end
  # end private
end
