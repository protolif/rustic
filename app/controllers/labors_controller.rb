class LaborsController < ApplicationController
  def index
    @ticket = Ticket.find params[:ticket_id]
    if @ticket.present?
      @labors = @ticket.labors
    else
      raise 'ticket not found'.inspect
    end
  end
end
