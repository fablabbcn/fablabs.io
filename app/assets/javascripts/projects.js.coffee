//= require masonry.pkgd.min.js
//= require trianglify.min.js

window.projects = []
window.map = null
window.showingContacts = false

down = false

windowHeight = ->
  $('#map').css('top', $('#main').offset().top).height($(window).height() - $('#main').offset().top)
  map.invalidateSize()

formatUser = (res) ->
  if res.loading
    return res
  markup = "<img alt='" + res.username + "' class='avatar tiny' src='" + res.avatar + "'>" + "&nbsp;&nbsp;&nbsp;" + res.username
  markup


formatUserSelection = (res) ->
  "<img alt='" + res.username + "' class='avatar tiny' src='" + res.avatar + "'>" + "&nbsp;&nbsp;&nbsp;" + res.username


formatLab = (res) ->
  if res.loading
    return res
  markup = "<img alt='" + res.name + "' class='avatar tiny' src='" + res.avatar + "'>" + "&nbsp;&nbsp;&nbsp;" + res.name
  markup


formatLabSelection = (res) ->
  "<img alt='" + res.name + "' class='avatar tiny' src='" + res.avatar + "'>" + "&nbsp;&nbsp;&nbsp;" + res.name


triglify = (h, w) ->
  size = Math.floor Math.random() * 99 + 1
  pattern = Trianglify(
      height: h,
      width: w,
      cell_size: size,
      x_colors: "random"
    )
  image = "url(" + pattern.png() + ")"

  return image

$(window).load ->

  if $(".radio")
    $(".radio").click ->
      val = $($($(this).parent()).children()[0]).is ':checked'
      if val
        console.log $($($(this).parent()).children()[0]).attr 'checked', false
      else
        $($($(this).parent()).children()[0]).click()

  if ($(".document_image")[0])
    val = $(".document_image")[0].value
    $("#file-input-name").text(val)

    $(".document_image").on "change", ->
      val = $(".document_image")[0].value
      $("#file-input-name").text(val)

  if ($("#project-container"))
    $("#project-container").masonry itemSelector: "#project-container li"

  if $("#project-container li .project").length > 0
    $("#project-container li .project").each ->
      if $(this).children(".project-title").css("background-image") == "none"
        image = triglify(150, 350)
        $(this).children(".project-title").css("background-image", image)

  if $("#contributions_attributes")
    $("#contributions_attributes").select2
      placeholder: "Select a user..",
      allowClear: true
      ajax:
        url: "https://api.fablabs.io/v0/users"
        dataType: "json"
        delay: 250
        data: (params) ->
          {
            q: params.term
          }
        processResults: (data) ->
          # parse the results into the format expected by Select2.
          # since we are using custom formatting functions we do not need to
          # alter the remote JSON data
          { results: data.users }
        cache: true
      escapeMarkup: (markup) ->
        markup
      minimumInputLength: 1
      templateResult: formatUser
      templateSelection: formatUserSelection

    if $(".lab_selection_attributes")
      $(".lab_selection_attributes").select2
        placeholder: "Select a lab..",
        allowClear: true
        ajax:
          url: "https://api.fablabs.io/v0/labs/search"
          dataType: "json"
          delay: 250
          data: (params) ->
            {
              q: params.term
            }
          processResults: (data) ->
            # parse the results into the format expected by Select2.
            # since we are using custom formatting functions we do not need to
            # alter the remote JSON data
            { results: data.labs }
          cache: true
        escapeMarkup: (markup) ->
          markup
        minimumInputLength: 1
        templateResult: formatLab
        templateSelection: formatLabSelection

  if $('body').hasClass('c-projects a-map')
    windowHeight = ->
      $('#map').css('top', $('#main').offset().top).height($(window).height() - $('#main').offset().top)
      map.invalidateSize()

    $(window).resize _.debounce(windowHeight,100)
    $('footer').css('margin-top', '800px')

    L.mapbox.accessToken = 'pk.eyJ1IjoidG9tYXNkaWV6IiwiYSI6ImRTd01HSGsifQ.loQdtLNQ8GJkJl2LUzzxVg'
    map = L.mapbox.map('map', 'mapbox.light', { scrollWheelZoom: true, zoomControl: false }).setView([
      50
      0
    ], 2)
    # removed for ios7 see: https://github.com/Leaflet/Leaflet.markercluster/issues/279
    # if !navigator.userAgent.match(/(iPad|iPhone|iPod touch);.*CPU.*OS 7_\d/i)
    #   window.markers = new L.MarkerClusterGroup
    #     showCoverageOnHover: true
    #     spiderfyOnMaxZoom: false
    #     removeOutsideVisibleBounds: true
    #     zoomToBoundsOnClick: true
    #     maxClusterRadius: 50
    #     disableClusteringAtZoom: 14
    # else
    window.markers = map

    window.map = map
    new L.Control.Zoom({ position: 'topleft' }).addTo(map)
    navigator.geolocation.getCurrentPosition((position)->
      map.setView([position.coords.latitude, position.coords.longitude], 4)
    )

    $.get "/projects/mapdata.json", (projects) ->
      for p in projects.projects
        if p.latitude and p.longitude
          icon = L.icon({
            iconUrl: window.mapIcons[p.kind]
            iconSize:     [35, 35]
            iconAnchor:   [17, 33]
            popupAnchor:  [0, -20]
          })
          p.marker = L.marker([p.latitude, p.longitude], {icon: icon})
          p.marker.bindPopup("<a href='/projects/#{p.id}'>#{p.title}</a>")
          window.markers.addLayer(p.marker)
          window.projects.push(p)

    map.addLayer(window.markers)

  return
