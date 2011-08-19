class LaborsController < ApplicationController
  before_filter :authenticate
  
  def new
    @title = "Add Labor to Ticket"
  end
  
  def create
    @ticket = Ticket.find(params[:labor][:ticket_id])
    @labor = @ticket.labors.create!(params[:labor])
    if @labor.save
      respond_to do |format|
        format.html { redirect_to @ticket }
        format.js
      end
    end
  end
end
