connect = require('./lib/connect')
# coffeekup = require('./lib/coffeekup')
coffeekup = require('coffeekup')
meryl = require('meryl')
now = require("now")
play = require('play')
# play.sound('./wavs/sfx/intro.wav', () ->
#   play.sound('./wavs/sfx/alarm.wav')
#   play.sound('./wavs/sfx/crinkle.wav')
#   play.sound('./wavs/sfx/flush.wav')
#   play.sound('./wavs/sfx/ding.wav')
#  )


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
# server.listen(80)
server.listen(8888)

console.log 'listening...'

everyone = now.initialize(server)
everyone.now.distributeMessage = (message) ->
  everyone.now.receiveMessage(this.now.name, message)


everyone.connected(  (message) ->
  everyone.now.receiveMessage(this.now.name, message)
  play.sound('./wavs/sfx/ding.wav')

)

everyone.now.updateElement = (className, top, left) ->
  everyone.now.receiveElement(className, top, left)
  play.sound('./wavs/drums/kick.wav')

