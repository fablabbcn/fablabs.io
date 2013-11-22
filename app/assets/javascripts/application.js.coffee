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
#= require jquery.turbolinks
#= require jquery_ujs
#= require turbolinks
#= require holder
#= require jquery.limit-1.2
#= require Control.Loading.js
#= require jquery.geocomplete
#= require leaflet.markercluster
#= require cocoon
#= require select2
#= require foundation
#= require jquery.autosize
#= require_tree .

initEvents = ->
  $('textarea').autosize({append: "\n"})
  $(document).foundation()
  $("select").select2()

  $('*[data-limit]').each ->
    $(this).limit parseInt($(this).data('limit')), $(this).data('counter')

  Holder.run()
  # $('.truncate > p').succinct
  #   size: 200

document.addEventListener "page:load", initEvents
$(document).ready initEvents
# jQuery -> initEvents
