#= require jquery
#= require jquery.turbolinks
#= require jquery_ujs
#= require turbolinks

$(document).ready ->
  $(".alert").hide().delay(100).fadeIn('fast').delay(3000).fadeOut('slow')
