class PartsController < ApplicationController
  before_filter :authenticate
  
  def create
    @ticket = Ticket.find(params[:part][:ticket_id])
    @part = @ticket.parts.create!(params[:part])
    if @part && @part.save
      respond_to do |format|
        format.html { redirect_to @ticket }
        format.js
      end
    end
  end
  
  def destroy
    @part = Part.find(params[:id])
    if @part && @part.destroy
      respond_to do |format|
        format.html { redirect_to @part.ticket }
        format.js
      end
    end
  end
end
