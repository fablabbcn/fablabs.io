window.labs = []
window.map = null
window.showingContacts = false

down = false

toggleActivityDateFields = (status) ->
  switch status
    when 'planned'
      $('.input.lab_activity_start_at').show()
      $('.input.lab_activity_inaugurated_at').hide()
      $('.input.lab_activity_closed_at').hide()
    when 'active'
      $('.input.lab_activity_start_at').show()
      $('.input.lab_activity_inaugurated_at').show()
      $('.input.lab_activity_closed_at').hide()
    else
      $('.input.lab_activity_start_at').show()
      $('.input.lab_activity_inaugurated_at').show()
      $('.input.lab_activity_closed_at').show()



ready = ->
  options = {
    valueNames: [ 'name', 'year' ]
  }
  window.userList = new List('students', options)

  last_valid_selection = $('.referee_approval').val


  # Toggle fields on load
  toggleActivityDateFields($('.activity-status-radio:checked').val())

  # Toggle fields on change
  $('.activity-status-radio').on 'change', (event) ->
    if $(event.target).is(':checked')
      toggleActivityDateFields(event.target.value)


  $('.referee_approval').on 'change', (event) ->
    if $(this).val().length > 3
      $(this).val last_valid_selection
    else
      last_valid_selection = $(this).val()
    return

  if $('#students-filter')
    $('#students-filter a').on 'click', (e) ->
      e.preventDefault()
      $('#students-filter dd').removeClass('active')
      $(this).parents('dd').addClass('active')
      if $(this).data('year')
        window.userList.filter (item) =>
          return parseInt(item._values.year) == parseInt($(this).data('year'))
      else
        window.userList.filter()

  $('#check-labs').on 'change', () ->
    alert("We already have '#{$(this).val()}' lab in our database, if it is not yet visible on the site it will be soon")

  $(document).on 'mousedown', () ->
    down = true
  .on 'mouseup', () ->
    down = false

  $('.opening-hours td').on 'mouseover', () ->
    $(this).toggleClass 'active' if (down)
  .on 'click', () ->
    $(this).toggleClass 'active'


  $('[data-toggle=offcanvas]').on 'click', () ->
    $('.row-offcanvas').toggleClass('active')


# Map in a Lab page


  $('#lab_name').on 'change', () ->
    unless $('#lab_slug').val()
      $('#lab_slug').val( $(this).val().toLowerCase().replace(/[^A-Za-z0-9]/g,''); )

  # $('.step-2').css(opacity: 0.5)
  $(".c-labs input#geocomplete").geocomplete
    map: "#location-picker-map"
    location: $('#geocomplete').data('latlng')
    details: ".c-labs.a-new .address"
    detailsAttribute: "data-geo"
    markerOptions:
      draggable: true
  .on 'geocode:dragged', (event, latLng) ->
    $("input#lab_latitude").val latLng.lat()
    $("input#lab_longitude").val latLng.lng()
  .on 'geocode:result', (event, result) ->
    $('.c-labs.a-new #lab_address_1').focus()
    $("input#lab_latitude").val result.geometry.location.lat()
    $("input#lab_longitude").val result.geometry.location.lng()
    $('select#lab_country_code').trigger('change')



$(document).ready ready
# $(document).on "page:load", ready