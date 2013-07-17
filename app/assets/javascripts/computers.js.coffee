$ ->
  # Submitless forms: because submit buttons are over.
  # submit textboxes right away
  $(".submitless input[type='text']").change ->
    $(this).closest('.submitless').submit()
  # submit textareas right away
  $('.submitless textarea').change ->
    $(this).closest('.submitless').submit()
  # don't submit checkboxes right away
  # wait for the slider transition to finish
  $(".submitless input[type='checkbox']").change ->
    delay  = 1000# 1 second
    slider = $(this)
    submit_the_form = -> slider.closest('.submitless').submit()
    setTimeout submit_the_form, delay
  # dropdown box (select) support
  $('.submitless select').change ->
    $(this).closest('.submitless').submit()
