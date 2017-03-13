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
  $('.activity-status-radio').change (event) ->
    if $(event.target).is(':checked')
      toggleActivityDateFields(event.target.value)


  $('.referee_approval').change (event) ->
    if $(this).val().length > 3
      $(this).val last_valid_selection
    else
      last_valid_selection = $(this).val()
    return

  if $('#students-filter')
    $('#students-filter a').click (e) ->
      e.preventDefault()
      $('#students-filter dd').removeClass('active')
      $(this).parents('dd').addClass('active')
      if $(this).data('year')
        window.userList.filter (item) =>
          return parseInt(item._values.year) == parseInt($(this).data('year'))
      else
        window.userList.filter()

  $('#check-labs').change ->
    alert("We already have '#{$(this).val()}' lab in our database, if it is not yet visible on the site it will be soon")

  $(document).mousedown ->
    down = true
  .mouseup ->
    down = false

  $('.opening-hours td').mouseover ->
    $(this).toggleClass 'active' if (down)
  .click ->
    $(this).toggleClass 'active'


  $('[data-toggle=offcanvas]').click ->
    $('.row-offcanvas').toggleClass('active')

  if $('body').hasClass('c-labs a-show') and $('#lab-map').length > 0
    location = [$('#lab-map').data('latitude'), $('#lab-map').data('longitude')]

    L.mapbox.accessToken = 'pk.eyJ1IjoidG9tYXNkaWV6IiwiYSI6ImRTd01HSGsifQ.loQdtLNQ8GJkJl2LUzzxVg'
    labmap = L.mapbox.map('lab-map', 'mapbox.light', { scrollWheelZoom: false, zoomControl: false, loadingControl: true }).setView(location, 14 )

    new L.Control.Zoom({ position: 'topright' }).addTo(labmap)
    icon = L.icon({
      iconUrl: window.mapIcons[$('#lab-map').data('kind-name')]
      iconSize:     [35, 35]
      iconAnchor:   [17, 33]
      popupAnchor:  [0, -20]
    })
    labmap.addLayer(L.marker(location, {icon: icon})).invalidateSize()
    $(window).resize _.debounce((-> labmap.invalidateSize()),500)

  $('#lab_name').change ->
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
  .bind "geocode:dragged", (event, latLng) ->
    $("input#lab_latitude").val latLng.lat()
    $("input#lab_longitude").val latLng.lng()
  .bind "geocode:result", (event, result) ->
    $('.c-labs.a-new #lab_address_1').focus()
    $("input#lab_latitude").val result.geometry.location.lat()
    $("input#lab_longitude").val result.geometry.location.lng()


# Embed map

  if $('body').hasClass('c-labs a-map') or $('body').hasClass('a-embed')
    L.mapbox.accessToken = 'pk.eyJ1IjoidG9tYXNkaWV6IiwiYSI6ImRTd01HSGsifQ.loQdtLNQ8GJkJl2LUzzxVg'
    map = L.mapbox.map('map', 'mapbox.light', { scrollWheelZoom: true, zoomControl: false }).setView([
      50
      0
    ], 2)

    new L.Control.Zoom({ position: 'topleft' }).addTo(map)
    navigator.geolocation.getCurrentPosition((position)->
      map.setView([position.coords.latitude, position.coords.longitude], 4)
    )

    allLabs = new (L.LayerGroup)
    map.addLayer(allLabs)

    $.get "/labs/mapdata.json", (labs) ->
      for lab in labs.labs
        if lab.latitude and lab.longitude
          icon = L.icon({
            iconUrl: window.mapIcons[lab.kind_name]
            iconSize:     [35, 35]
            iconAnchor:   [17, 33]
            popupAnchor:  [0, -20]
          })
          lab.marker = L.marker([lab.latitude, lab.longitude], {icon: icon})
          lab.marker.bindPopup("<a target='_top' href='#{lab.url}'>#{lab.name}</a>").addTo allLabs
          window.labs.push(lab)

    map.on 'zoomend', ->
      console.log allLabs
      currentZoom = map.getZoom()
      LeafIcon = L.Icon.extend(options: iconSize: [
          currentZoom
          currentZoom
          ])
      allLabs.setIcon LeafIcon
      return

    windowHeight = ->
      $('#map').css('top', $('#main').offset().top).height($(window).height() - $('#main').offset().top)
      map.invalidateSize()
    $(window).resize _.debounce(windowHeight,100)

$(document).ready ready
# $(document).on "page:load", ready
