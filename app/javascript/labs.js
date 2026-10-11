/*
 * Ported from labs.js.coffee (CoffeeScript is no longer supported
 */

import jQuery from "jquery";

window.$ = window.jQuery = jQuery;

// Google Maps geocoding helper (needs the Google Maps API script tag)
require("geocomplete");

window.labs = []
window.map = null
window.showingContacts = false

var down = false

function toggleActivityDateFields(status) {
  switch (status) {
    case 'planned':
      $('.input.lab_activity_start_at').show()
      $('.input.lab_activity_inaugurated_at').hide()
      $('.input.lab_activity_closed_at').hide()
      break
    case 'active':
      $('.input.lab_activity_start_at').show()
      $('.input.lab_activity_inaugurated_at').show()
      $('.input.lab_activity_closed_at').hide()
      break
    default:
      $('.input.lab_activity_start_at').show()
      $('.input.lab_activity_inaugurated_at').show()
      $('.input.lab_activity_closed_at').show()
  }
}

function ready() {
  var options = {
    valueNames: [ 'name', 'year' ]
  }
  // window.userList = new List('students', options)

  var last_valid_selection = $('.referee_approval').val()

  // Toggle fields on load
  toggleActivityDateFields($('.activity-status-radio:checked').val())

  // Toggle fields on change
  $('.activity-status-radio').on('change', function(event) {
    if ($(event.target).is(':checked')) {
      toggleActivityDateFields(event.target.value)
    }
  })

  $('.referee_approval').on('change', function(event) {
    if ($(this).val().length > 3) {
      $(this).val(last_valid_selection)
    } else {
      last_valid_selection = $(this).val()
    }
  })

  // if ($('#students-filter')) {
  //   $('#students-filter a').on('click', function(e) {
  //     e.preventDefault()
  //     $('#students-filter dd').removeClass('active')
  //     $(this).parents('dd').addClass('active')
  //     if ($(this).data('year')) {
  //       window.userList.filter(function(item) {
  //         return parseInt(item._values.year) == parseInt($(this).data('year'))
  //       }.bind(this))
  //     } else {
  //       window.userList.filter()
  //     }
  //   })
  // }

  $('#check-labs').on('change', function() {
    alert("We already have '" + $(this).val() + "' lab in our database, if it is not yet visible on the site it will be soon")
  })

  $(document).on('mousedown', function() {
    down = true
  }).on('mouseup', function() {
    down = false
  })

  $('.opening-hours td').on('mouseover', function() {
    if (down) { $(this).toggleClass('active') }
  }).on('click', function() {
    $(this).toggleClass('active')
  })

  $('[data-toggle=offcanvas]').on('click', function() {
    $('.row-offcanvas').toggleClass('active')
  })

  // Map in a Lab page

  $('#lab_name').on('change', function() {
    if (!$('#lab_slug').val()) {
      $('#lab_slug').val($(this).val().toLowerCase().replace(/[^A-Za-z0-9]/g, ''))
    }
  })

  function updateFormWithLatLng(lat, lng) {
    $('.c-labs.a-new #lab_address_1').focus()
    $("input#lab_latitude").val(lat)
    $("input#lab_longitude").val(lng)
    $('select#lab_country_code').trigger('change')
    $('#lab_geoinfo')
      .find('strong')
      .text(Number(lat).toFixed(6) + ' / ' + Number(lng).toFixed(6))
  }

  $(".c-labs input#geocomplete").geocomplete({
    map: "#location-picker-map",
    location: $('#geocomplete').data('latlng'),
    details: ".c-labs.a-new .address",
    detailsAttribute: "data-geo",
    markerOptions: {
      draggable: true
    }
  })
  .on('geocode:dragged', function(event, latLng) {
    updateFormWithLatLng(latLng.lat(), latLng.lng())
  })
  .on('geocode:result', function(event, result) {
    updateFormWithLatLng(result.geometry.location.lat(), result.geometry.location.lng())
  })
}

$(document).ready(ready)
