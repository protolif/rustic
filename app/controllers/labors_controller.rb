class LaborsController < ApplicationController
  def index
    @ticket = Ticket.find params[:ticket_id]
    if @ticket.present?
      @labors = @ticket.labors
    else
      raise 'ticket not found'.inspect
    end
  end

  def update
    @labor = Labor.find params[:id]
    if @labor.present?
      if @labor.update_attributes(labor_attributes)
        redirect_to ticket_labors_path(@labor.ticket)
      else
        raise 'unable to update labor'.inspect
      end
    else
      raise 'unable to find labor'.inspect
    end
  end

  def new
    @ticket = Ticket.find params[:ticket_id]
    @labor = @ticket.labors.new
  end

  def create
    if @ticket = Ticket.find(params[:ticket_id])
      if @ticket.labors.create!(labor_attributes)
        redirect_to ticket_labors_path(@ticket)
      else
        render :new
      end
    else
      raise 'unable to find ticket'.inspect
    end
  end
  
  private
    def labor_attributes
      params.require(:labor).permit(:service, :notes, :price)
    end
  #end private
end
