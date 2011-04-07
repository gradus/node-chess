doctype 5
html ->
  head ->
    title 'Node Chess'
    link rel: 'stylesheet', href: '/stylesheets/app.css'
    script type: 'text/javascript', src: '/nowjs/now.js'
    script type: 'text/javascript', src: 'http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js'
    script type: 'text/javascript', src: 'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.11/jquery-ui.min.js'
    script type: 'text/javascript', src: '/javascripts/jquery.cookie.js'
  body ->
    div id: 'wrap', ->
      div id: 'header', ->
        a href: '/', ->
          h2 ->
            "Node Chess"
      div id: 'content',
        -> @render @content, @context
      div id: 'footer', ->
        span -> img src: '/images/coffeescript.png'
        p ->
          em 'Powered with Meryl, Node.js, coffee-script, Redis nowJS and coffeeKup!'
        p ->  
          a href: 'http://github.com/gradus/node-chess', style: 'text-decoration:underline;', ->
            'Source Code'
