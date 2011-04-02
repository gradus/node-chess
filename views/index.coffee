h2 -> 
  "The following Muppets are involved"
ul ->
  for name, index in @people
    li -> 
      a href: "/people/#{index}", -> name
div id: 'messages', ->
  input id: 'text_input', type: 'text'
  input id: 'send_button', type: 'submit'
div id: 'clear'
coffeescript ->
  now.name = prompt("What's your name?", "")
  $("#send_button").click( () ->
    console.log "yo"
    now.distributeMessage($("#text_input").val())
    $("#text_input").val("")
  )
  now.receiveMessage = (name, message) ->
    $("#messages").append("<br>" + name + ": " + message)
