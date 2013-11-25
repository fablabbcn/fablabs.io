Messenger.options = {
  extraClasses: 'messenger-fixed messenger-on-bottom messenger-on-right',
  theme: 'flat'
}

jQuery ->
  $('.flash').hide().each ->
    Messenger().post
      message: $(this).text()
      type: 'error'