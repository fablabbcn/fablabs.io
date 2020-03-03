ready = ->
  if $('body').hasClass('c-organizations a-show') and $('#organization-map').length > 0
    geojson = $('#organization-map').data('geojson')
    latitude = $('#organization-map').data('latitude') || 0
    longitude = $('#organization-map').data('longitude') || 0
    zoom = $('#organization-map').data('zoom') || 14

    L.mapbox.accessToken = 'pk.eyJ1IjoidG9tYXNkaWV6IiwiYSI6ImNpaWcyMHU0bjAwM2x2emt1cG5iMzE3bXIifQ.wWNloP12TwdfeKyLHaXpSA'
    map = L.mapbox.map('organization-map', 'mapbox.light', { scrollWheelZoom: false, zoomControl: false, loadingControl: true }).setView([latitude, longitude], zoom)

    L.geoJson(geojson, { style: L.mapbox.simplestyle.style }).addTo(map)


  $(".c-organizations input#geocomplete").geocomplete
    map: "#location-picker-map"
    location: $('#geocomplete').data('latlng')
    details: ".c-organizations .address"
    detailsAttribute: "data-geo"
    markerOptions:
      draggable: true
  .bind "geocode:dragged", (event, latLng) ->
    $("input#organization_latitude").val latLng.lat()
    $("input#organization_longitude").val latLng.lng()
  .bind "geocode:result", (event, result) ->
    $('.c-organizations #organization_address_1').focus()
    $("input#organization_latitude").val result.geometry.location.lat()
    $("input#organization_longitude").val result.geometry.location.lng()

$(document).ready ready
