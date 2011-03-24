connect = require('./lib/connect')
sys = require("sys")
http = require('http')
_ = require('underscore')
coffeekup = require('./lib/coffeekup.coffee')
meryl = require('meryl')
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

people = ['Animal', 'Beaker', 'Piggy', 'Kermit']
