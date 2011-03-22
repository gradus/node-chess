doctype 5
html ->
  head ->
    title 'KLOP is coming'
    link rel: 'stylesheet', href: '/stylesheets/app.css'
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
          em 'Powered with Meryl, Node.js, coffee-script, and coffeeKup!'

