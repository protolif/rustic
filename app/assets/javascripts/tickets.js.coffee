$ ->
  # When you click a row in the table
  $('#ticket-index tr').click ->
    # It should return the id of the row
    alert $(this).data('id')
  $('#toggle_search').click (event) ->
    # Override the link click handler
    event.preventDefault()
    # It should toggle the visibility of the search_container
    search_container = $(this).closest('.web_view').find('.search_container')
    search_container.css('display', 'block')
    # It should set the focus in the search box
    search_container.find('.search_box').focus()
