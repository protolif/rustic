class PaymentsController < ApplicationController
  before_filter :authenticate
  
  def create
    @ticket  = Ticket.find(params[:payment][:ticket_id])
    @payment = @ticket.payments.create!(params[:payment])
    if @payment && @payment.save
      respond_to do |format|
        format.html { redirect_to @ticket }
        format.js
      end
    end
  end
  
  def destroy
    @payment = Payment.find(params[:id])
    if @payment && @payment.destroy
      respond_to do |format|
        format.html { redirect_to @payment.ticket }
        format.js
      end
    end
  end
end
