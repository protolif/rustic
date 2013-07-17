$ ->
  $('#toggle_search').click (event) ->
    # Override the link click handler
    event.preventDefault()
    # It should toggle the visibility of the search_container
    search_container = $(this).closest('.web_view').find('.search_container')
    search_container.css('display', 'block')
    # It should set the focus in the search box
    search_container.find('.search_box').focus()
  
  # move the notes label behind the textarea when scrolling
  $('.edit_notes').scroll ->
    # in a scroll view, scrollTop is the distance
    # between the content top and the viewable top
    if $(this).scrollTop() > 0
      # move the label element behind the scroll view
      # it will remain partially visible due to alpha
      $('.notes_label').css('z-index', '-1')
    else
      # first check if we should write
      # because reading is presumably faster than writing
      if $('.notes_label').css('z-index') == '-1'
        $('.notes_label').css('z-index', '2')
