window.labs = []
window.map = null
window.showingContacts = false

ready = ->

  if $('body').hasClass 'c-labs a-show'
    location = [$('#lab-map').data('latitude'), $('#lab-map').data('longitude')]
    labmap = L.map('lab-map', { scrollWheelZoom: false, zoomControl: false }).setView(location, 14 )
    new L.Control.Zoom({ position: 'topright' }).addTo(labmap)
    L.tileLayer('http://{s}.tile.cloudmade.com/d8b794cdcd1e4e37bd83addfd40b7c68/110755/256/{z}/{x}/{y}.png', {}).addTo(labmap)
    icon = L.icon({
      iconUrl: 'http://labs.fabfoundation.org/assets/map-icon-fab_lab-6f15e0c02e24db66d8eccc86c7a2076d.png'
      iconSize:     [35, 35]
      iconAnchor:   [17, 33]
      popupAnchor:  [0, -20]
    })
    labmap.addLayer L.marker(location, {icon: icon})

  $('#lab_name').change ->
    unless $('#lab_slug').val()
      $('#lab_slug').val( $(this).val().toLowerCase().replace(/[^A-Za-z0-9]/g,''); )

  $(".c-labs input#geocomplete").geocomplete
    map: "#location-picker-map"
    location: $('#geocomplete').data('latlng')
    details: ".c-labs .address"
    detailsAttribute: "data-geo"
    markerOptions:
      draggable: true

  $(".c-labs #geocomplete").bind "geocode:dragged", (event, latLng) ->
    $("input#lab_latitude").val latLng.lat()
    $("input#lab_longitude").val latLng.lng()

  if $('body').hasClass 'c-labs a-map'
    window.markers = new L.MarkerClusterGroup
      showCoverageOnHover: true
      spiderfyOnMaxZoom: true
      removeOutsideVisibleBounds: true
      zoomToBoundsOnClick: true

    map = L.map('map', { scrollWheelZoom: false, zoomControl: false }).setView([50, 0], 2 )
    window.map = map
    new L.Control.Zoom({ position: 'topleft' }).addTo(map)
    L.tileLayer('http://{s}.tile.cloudmade.com/384aceabcd0942189d0e93cf0e98cd31/90734/256/{z}/{x}/{y}.png').addTo(map)
    navigator.geolocation.getCurrentPosition((position)->
      map.setView([position.coords.latitude, position.coords.longitude], 4)
    )

    $.get "/l.json", (labs) ->
      for lab in labs.labs
        if lab.latitude
          icon = L.icon({
            iconUrl: 'http://labs.fabfoundation.org/assets/map-icon-fab_lab-6f15e0c02e24db66d8eccc86c7a2076d.png'
            # window.image_path("map-icon-#{lab.kind_string}.png")
            iconSize:     [35, 35]
            iconAnchor:   [17, 33]
            popupAnchor:  [0, -20]
          })
          lab.marker = L.marker([lab.latitude, lab.longitude], {icon: icon})
          lab.marker.bindPopup("<a href='#{lab.url}'>#{lab.name}</a>")
          window.markers.addLayer(lab.marker)
          window.labs.push(lab)
    map.addLayer(window.markers)

$(document).ready ready
# $(document).on "page:load", ready