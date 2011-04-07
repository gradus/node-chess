connect = require('./lib/connect')
coffeekup = require('./lib/coffeekup.coffee')
meryl = require('meryl')
now = require("now")
redis = require("redis")
client = redis.createClient(9010, 'bass.redistogo.com')
dbAuth = () -> client.auth('e212a2dcfe7eed6c849ddfce6c6c0e15')

client.addListener('connected', dbAuth)
client.addListener('reconnected', dbAuth)
dbAuth()

client.on("error", (err) ->
    console.log("Error " + err)
)

meryl.p(connect.static('public'))

meryl.get '/', (req, resp) ->
  resp.render 'layout',
    content: 'index'
    context:
      people: people

meryl.get '/people/{personid}', (req, resp) ->
  client.hgetall("#{people[req.params.personid]}", (err, obj) ->
    resp.render 'layout',
    content: 'show'
    context:
      person: obj.name
      profile: obj.profile
  )

server = connect(
  meryl.cgi
    templateExt: '.coffee'
    templateFunc: coffeekup.adapters.meryl
    templateDir: 'views'
    connect.logger()
)
server.listen(8984)
console.log 'listening...'

everyone = now.initialize(server)
everyone.now.distributeMessage = (message) ->
  everyone.now.receiveMessage(this.now.name, message)

everyone.connected(  (message) ->
  everyone.now.receiveMessage(this.now.name, message)
)

everyone.now.updateElement = (className, top, left) ->
  everyone.now.receiveElement(className, top, left)

people = ['Animal', 'Beaker', 'Piggy', 'Kermit']
