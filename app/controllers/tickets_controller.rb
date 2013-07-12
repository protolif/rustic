class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all limit: 20
  end
end
