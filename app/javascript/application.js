/*
 * Main application JavaScript — bundled by esbuild (jsbundling-rails) into
 * app/assets/builds/application.js.
 *
 */

import bootstrap from "bootstrap";
import flatpickr from "flatpickr";
import jQuery from "jquery";
import select2 from 'select2';
import Rails from '@rails/ujs'

window.$ = window.jQuery = jQuery;

// Nested forms (jQuery plugin; needs window.jQuery)
require("@nathanvda/cocoon")

window.Rails = Rails
Rails.start()

document.addEventListener("DOMContentLoaded", function() {
  // Select2 dropdowns (its CommonJS export is a factory that must be called)
  select2();

  $("select").select2({ width: '100%' });

  // This flatpickr does not have Time, HH:MM
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
});
