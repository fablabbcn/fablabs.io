# http://cloudmade.com/documentation/map-tiles

window.labs = []
window.map = null
window.showingContacts = false

osmAttrib = 'Map data © <a href="http://www.openstreetmap.org" target="_blank">OpenStreetMap</a> contributors'

ready = ->

  # if $('body').hasClass 'a-home'
  #   map = L.map('homepage-map', { scrollWheelZoom: false, zoomControl: false }).setView([50, 0], 2 )
  #   L.tileLayer('https://ssl_tiles.cloudmade.com/384aceabcd0942189d0e93cf0e98cd31/90734/256/{z}/{x}/{y}.png').addTo(map)
  #   $(window).resize _.debounce((-> map.invalidateSize()),500)
  #   # navigator.geolocation.getCurrentPosition((position)->
  #   #   map.setView([position.coords.latitude, position.coords.longitude], 13)
  #   # )

  $('[data-toggle=offcanvas]').click ->
    $('.row-offcanvas').toggleClass('active')

  if $('body').hasClass('c-labs a-show') and $('#lab-map').length > 0
    location = [$('#lab-map').data('latitude'), $('#lab-map').data('longitude')]
    labmap = L.map('lab-map', { scrollWheelZoom: false, zoomControl: false, loadingControl: true }).setView(location, 14 )
    new L.Control.Zoom({ position: 'topright' }).addTo(labmap)
    L.tileLayer('https://ssl_tiles.cloudmade.com/d8b794cdcd1e4e37bd83addfd40b7c68/110755/256/{z}/{x}/{y}.png', { attribution: osmAttrib }).addTo(labmap)
    icon = L.icon({
      iconUrl: '//i.imgur.com/bKe7MW2.png'
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
    $(".c-labs.a-new input#lab_latitude").val result.geometry.location.ob
    $(".c-labs.a-new input#lab_longitude").val result.geometry.location.pb


  if $('body').hasClass 'c-labs a-map'

    map = L.map('map', { scrollWheelZoom: true, zoomControl: false }).setView([50, 0], 2 )

    # removed for ios7 see: https://github.com/Leaflet/Leaflet.markercluster/issues/279
    if !navigator.userAgent.match(/(iPad|iPhone|iPod touch);.*CPU.*OS 7_\d/i)
      window.markers = new L.MarkerClusterGroup
        showCoverageOnHover: true
        spiderfyOnMaxZoom: false
        removeOutsideVisibleBounds: true
        zoomToBoundsOnClick: true
        maxClusterRadius: 50
        disableClusteringAtZoom: 14
    else
      window.markers = map

    window.map = map
    new L.Control.Zoom({ position: 'topleft' }).addTo(map)
    L.tileLayer('https://ssl_tiles.cloudmade.com/384aceabcd0942189d0e93cf0e98cd31/90734/256/{z}/{x}/{y}.png', { attribution: osmAttrib, maxZoom: 14 }).addTo(map)
    navigator.geolocation.getCurrentPosition((position)->
      map.setView([position.coords.latitude, position.coords.longitude], 4)
    )

    $.get "/labs.json?per=1000", (labs) ->
      for lab in labs.labs
        if lab.latitude
          icon = L.icon({
            iconUrl: window.mapIcons['fablab']
            iconSize:     [35, 35]
            iconAnchor:   [17, 33]
            popupAnchor:  [0, -20]
          })
          lab.marker = L.marker([lab.latitude, lab.longitude], {icon: icon})
          lab.marker.bindPopup("<a href='#{lab.url}'>#{lab.name}</a>")
          window.markers.addLayer(lab.marker)
          window.labs.push(lab)
    map.addLayer(window.markers)

    windowHeight = ->
      $('#map').css('top', $('#main').offset().top).height($(window).height() - $('#main').offset().top)
      map.invalidateSize()
    $(window).resize _.debounce(windowHeight,100)

$(document).ready ready
# $(document).on "page:load", ready
