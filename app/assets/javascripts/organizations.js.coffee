ready = ->
  if $('body').hasClass('c-organizations a-show') and $('#organization-map').length > 0
    geojson = $('#organization-map').data('geojson')
    latitude = $('#organization-map').data('latitude') || 0
    longitude = $('#organization-map').data('longitude') || 0
    zoom = $('#organization-map').data('zoom') || 14

    L.mapbox.accessToken = 'pk.eyJ1IjoidG9tYXNkaWV6IiwiYSI6ImRTd01HSGsifQ.loQdtLNQ8GJkJl2LUzzxVg'
    map = L.mapbox.map('organization-map', 'mapbox.light', { scrollWheelZoom: false, zoomControl: false, loadingControl: true }).setView([latitude, longitude], zoom)

    L.geoJson(geojson, { style: L.mapbox.simplestyle.style }).addTo(map)



$(document).ready ready
