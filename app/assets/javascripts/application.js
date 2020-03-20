// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.limit-1.2
//= require Control.Loading.js
//= require jquery.geocomplete
//= require cocoon
//= require list
//= require flatpickr
//= require underscore
//= require select2/dist/js/select2
//= require messenger
//= require messenger-theme-flat
//= require placeholders
//= require jquery.autosize
//= require alerts
//= require moment
//= require trumbowyg/trumbowyg
//= require spin.js/spin
//= require leaflet-spin
//= require_tree .


document.addEventListener("DOMContentLoaded", function() {

  $('[data-toggle="tooltip"]').tooltip();
  $('textarea.trumbowyg').trumbowyg();
  $("select").select2();

  // This flatpicker does not have the Time, HH:MM
  flatpickr('.flatpickr', {
    enableTime: false,
    dateFormat: "Y-m-d",
    time_24hr: true
  })

  // This flatpickr has Time, HH:MM
  flatpickr('.flatpickr-time', {
    enableTime: true,
    dateFormat: "Y-m-d H:i",
    time_24hr: true
  })

  return $('*[data-limit]').each(function() {
    return $(this).limit(parseInt($(this).data('limit')), $(this).data('counter'));
  });

});
