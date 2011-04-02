h2 -> 
  "The following Muppets are involved"
ul ->
  for name, index in @people
    li -> 
      a href: "/people/#{index}", -> name
div id: 'messages'
div id: 'chat_input', ->
  input id: 'text_input', type: 'text'
  input id: 'send_button', type: 'submit', value: 'Chat'

coffeescript ->
  jQuery(document).ready ->
    if $.cookie('klop_name')
      now.name = $.cookie('klop_name')
    else
      now.name = prompt("What's your name?", "")
      $.cookie('klop_name', now.name)

    $("#text_input").keyup (event) ->
      if event.keyCode == 13
        $("#messages").show()
        now.distributeMessage($("#text_input").val())
        $("#text_input").val("")

    $("#send_button").click( () ->
      $("#messages").show()
      now.distributeMessage($("#text_input").val())
      $("#text_input").val("")
    )
    now.receiveMessage = (name, message) ->
      $("#messages").append("<p>" + name + ": " + message + "</p>")
