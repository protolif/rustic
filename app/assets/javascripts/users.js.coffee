$ ->
  # When you click a row in the table
  $('.clickable').click ->
    # It should take the user to the row's show page
    window.location = $(this).data('url')