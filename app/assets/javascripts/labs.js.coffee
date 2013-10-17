window.labs = []
window.map = null
window.showingContacts = false

ready = ->

  if $('body').hasClass 'c-labs a-map'
    # window.markers = new L.MarkerClusterGroup
    #   showCoverageOnHover: true
    #   spiderfyOnMaxZoom: true
    #   removeOutsideVisibleBounds: true
    #   zoomToBoundsOnClick: true

    map = L.map('map', { scrollWheelZoom: false, zoomControl: false }).setView([50, 0], 2 )
    window.map = map
    new L.Control.Zoom({ position: 'topleft' }).addTo(map)
    L.tileLayer('http://{s}.tile.cloudmade.com/384aceabcd0942189d0e93cf0e98cd31/90734/256/{z}/{x}/{y}.png').addTo(map)
    navigator.geolocation.getCurrentPosition((position)->
      map.setView([position.coords.latitude, position.coords.longitude], 4)
    )

    # $.get "/labs.json", (labs) ->
    #   for lab in labs
    #     if lab.lat
    #       icon = L.icon({
    #         iconUrl: 'http://labs.fabfoundation.org/assets/map-icon-fab_lab-6f15e0c02e24db66d8eccc86c7a2076d.png'
    #         # window.image_path("map-icon-#{lab.kind_string}.png")
    #         iconSize:     [35, 35]
    #         iconAnchor:   [17, 33]
    #         popupAnchor:  [0, -20]
    #       })
    #       lab.marker = L.marker([lab.lat, lab.lng], {icon: icon})
    #       lab.marker.bindPopup("<a href='/#{lab.slug}'>#{lab.name}</a>")
    #       window.markers.addLayer(lab.marker)
    #       window.labs.push(lab)
    # map.addLayer(window.markers)

$(document).ready ready
$(document).on "page:load", ready