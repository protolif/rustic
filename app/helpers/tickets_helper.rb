module TicketsHelper
  def ticket_index_row(ticket)
    ["#{ticket.customer.fname} #{ticket.customer.lname}",
    ticket.computer.make, ticket.computer.model, truncate(ticket.issue),
    (ticket.technician) ? "#{ticket.technician.fname} #{ticket.technician.lname.first}." : "None",
    (ticket.status.nil?) ? "None" : ticket.status,
    "#{time_ago_in_words(ticket.created_at)} ago"]
  end
end
