ready = ->

# Jitsi Meet integration

  if $('body').hasClass('c-discourse a-embed') > 0

    $('#launch-jitsi').click ->
      room = 'Fablabs.io-' + Math.random().toString(36).substr(2, 8)
      domain = 'meet.jit.si'
      jitsiUrl = "http://"+domain+"/"+room
      $("#jitsi-url").replaceWith 'Invite other users from within the video call or by sending them this link: <a target="_blank" href="'+jitsiUrl+'">'+jitsiUrl+'</a>'
      width = $("div").width '#jitsi-row'
      height = 600
      htmlElement = document.getElementById('jitsi-embed')
      configOverwrite = {}
      interfaceConfigOverwrite = filmStripOnly: false
      api = new JitsiMeetExternalAPI(domain, room, width, height, htmlElement, configOverwrite, interfaceConfigOverwrite)
      return




$(document).ready ready
