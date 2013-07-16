$ ->
  $('.submitless input').change ->
    $(this).closest('.submitless').submit()
  $('.submitless select').change ->
    $(this).closest('.submitless').submit()
