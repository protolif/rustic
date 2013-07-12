$ ->
  # When you click a row in the table
  $('#ticket-index tr').click ->
    # It should return the id of the row
    alert $(this).data('id')
