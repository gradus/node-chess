doctype 5
html ->
  head ->
    title 'KLOP is coming'
    link rel: 'stylesheet', href: '/stylesheets/app.css'
    script type: 'text/javascript', src: '/nowjs/now.js'
    script type: 'text/javascript', src: 'http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js'
    script type: 'text/javascript', src: '/javascripts/jquery.cookie.js'
  body ->
    div id: 'wrap', ->
      div id: 'header', ->
        a href: '/', ->
          h1 ->
            "KLOP is Coming"
      div id: 'content',
        -> @render @content, @context
      div id: 'footer', ->
        span -> img src: '/images/coffeescript.png'
        p ->
          em 'Powered with Meryl, Node.js, coffee-script, Redis and coffeeKup!'
