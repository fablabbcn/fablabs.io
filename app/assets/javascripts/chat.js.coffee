jQuery ->
  PrivatePub.subscribe "/chat_messages/new", (data, channel) ->
    console.log data
    $('#chat').append("<li><a href='/users/#{data.author.id}'>#{data.author.name}</a> - #{data.chat_message.content}")
    $('#chat-window').scrollTop($('#chat').height());
    $('#chat-message').focus().val("")

  $('#send-chat-message').click ->
    $('#chat-message').focus()
    return $('#chat-message').val() != ""
