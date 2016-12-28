# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require jquery.limit-1.2
#= require Control.Loading.js
#= require jquery.geocomplete
#= require leaflet.markercluster
#= require private_pub
#= require cocoon
#= require list
#= require jquery.timepicker
#= require underscore
#= require select2
#= require messenger
#= require messenger-theme-flat
#= require placeholders
#= require jquery.autosize
#= require alerts
#= require moment
#= require trumbowyg/trumbowyg
#= require_tree .
#
#

initEvents = ->

  $('textarea.trumbowyg').trumbowyg()
  # {append: "\n"}
  $("select").select2()

  $('*[data-limit]').each ->
    $(this).limit parseInt($(this).data('limit')), $(this).data('counter')

document.addEventListener "page:load", initEvents
$(document).ready initEvents
