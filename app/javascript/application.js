/*
 * Main application JavaScript — bundled by esbuild (jsbundling-rails) into
 * app/assets/builds/application.js.
 *
 * Plain CommonJS `require` (not ESM import) is used so that modules evaluate
 * in exactly the same order as the old Sprockets //= require manifest, and so
 * legacy libraries that rely on globals (window.$, window.L, ...) keep working.
 */

// jQuery first; publish as globals for the legacy plugins loaded below.
const $ = require("jquery/dist/jquery.js")
window.$ = window.jQuery = $

// Bootstrap 4 (bundle includes Popper)
require("bootstrap/dist/js/bootstrap.bundle.js")

// Vendored jQuery plugins and libraries (vendor/assets/javascripts)
require("../../vendor/assets/javascripts/jquery.limit-1.2.js")

// Leaflet maps (attaches window.L)
window.L = require("leaflet/dist/leaflet-src.js")

// Leaflet loading-indicator control (needs the global L)
require("../../vendor/assets/javascripts/Control.Loading.js")

// Google Maps geocoding helper (needs the Google Maps API script tag)
require("../../vendor/assets/javascripts/jquery.geocomplete.js")

// Nested forms (jQuery plugin; needs window.jQuery)
require("./vendor/cocoon.js")

// List.js collection filtering (exports the List class under CommonJS)
window.List = require("../../vendor/assets/javascripts/list.js")

// Date picker
window.flatpickr = require("./vendor/flatpickr.js")

// Underscore.js (self-attaches to window._)
require("../../vendor/assets/javascripts/underscore.js")

// Select2 dropdowns (its CommonJS export is a factory that must be called)
require("select2/dist/js/select2.js")()

// Messenger notifications (self-attaches to window.Messenger)
require("../../vendor/assets/javascripts/messenger.js")
require("../../vendor/assets/javascripts/messenger-theme-flat.js")

// Textarea autosize (jQuery plugin)
require("../../vendor/assets/javascripts/jquery.autosize.js")

// Moment.js
window.moment = require("./vendor/moment.js")

// Spinner + Leaflet spin plugin (its CommonJS export is an installer function)
window.Spinner = require("spin.js/spin.js")
require("leaflet-spin")(window.L, window.Spinner)

// Rails UJS (under a bundler it does not auto-start, so start it explicitly)
const Rails = require("./vendor/rails-ujs.js")
window.Rails = Rails
Rails.start()

require("./labs.js")

document.addEventListener("DOMContentLoaded", function() {
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

  $('*[data-limit]').each(function() {
    $(this).limit(parseInt($(this).data('limit')), $(this).data('counter'));
  });
});
