connect = require('./lib/connect')
coffeekup = require('./lib/coffeekup.coffee')
meryl = require('meryl')
now = require("now")

meryl.p(connect.static('public'))

meryl.get '/', (req, resp) ->
  resp.render 'layout',
    content: 'index'

server = connect(
  meryl.cgi
    templateExt: '.coffee'
    templateFunc: coffeekup.adapters.meryl
    templateDir: 'views'
    connect.logger()
)
server.listen(80)
console.log 'listening...'

everyone = now.initialize(server)
everyone.now.distributeMessage = (message) ->
  everyone.now.receiveMessage(this.now.name, message)

everyone.connected(  (message) ->
  everyone.now.receiveMessage(this.now.name, message)
)

everyone.now.updateElement = (className, top, left) ->
  everyone.now.receiveElement(className, top, left)
