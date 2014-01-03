jQuery ->
  PrivatePub.subscribe "/chat_messages/new", (data, channel) ->
    console.log data
    name = if (window.me == data.author.id) then "You" else data.author.name;
    $('#chat').append("<li class='#{name}'><a href='/users/#{data.author.id}'>#{name}</a> - #{data.chat_message.content}")
    $('#chat-window').scrollTop($('#chat').height());
    $('#chat-message').focus().val("")

  $('#send-chat-message').click ->
    $('#chat-message').focus()
    return $('#chat-message').val() != ""
