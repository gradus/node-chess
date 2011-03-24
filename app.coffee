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

client.hmset "Animal", "id", "1", "name", "Animal", "profile", "Animal is the drummer on The Muppet Show, performing with Dr. Teeth and the Electric Mayhem. Animal is a crazed percussionist with three styles of music -- loud, louder, and deafening. He speaks in a guttural shout, often repeating a few simple phrases, such as \"BEAT DRUMS! BEAT DRUMS!\" or \"WO-MAN!\" In relatively calmer moods, he is capable of more coherent conversation, but these instances are infrequent.  Animal first appeared in the 1975 pilot, The Muppet Show: Sex and Violence, chained up in a basement cell when he wasn\'t onstage performing with the Electric Mayhem. He later became a main character on The Muppet Show, and his unrestrained style has made him popular with young people for decades.  Frank Oz says that he had his character down to five words: Sex, sleep, food, drums and pain. Occasionally, two of those essentials, food and drums, are interchangeable. In The Muppet Movie, Dr. Teeth had to remind Animal to beat, and not eat, his drums. In The Muppet Show episode 110, when asked by Kermit if he preferred drumming to food, Animal replied that drums are food.  Animal\'s wild attitude can be compared to Cookie Monster. In A Muppet Family Christmas, after observing Cookie Monster eating all of Janice\'s cookies in his signature manner, Animal comments, \"That my kind of fella!\"  Animal\'s family life is generally non-existent, and outside of the band, the Muppet Show troupe, and women in general, he has no other relationships. A significant exception is depicted in the book The Case of the Missing Mother, which reveals the existence of Animal\'s mother, LaVerne. LaVerne is also a drummer, and it\'s implied that percussion skills are a family trait.  It is a popular legend that Animal was inspired by Keith Moon, the wild drummer of the Who.  Mick Fleetwood of Fleetwood Mac is also sometimes cited as the inspiration for Animal.  However, there is no evidence in the original sketches for the character that suggest that he was based on anybody in particular.  Three of the other members of the Electric Mayhem were created by Muppet designer Michael K. Frith, and the sketches reproduced in the 1981 book Of Muppets and Men show that they were based on famous musicians. Dr. Teeth is a cross between Dr. John and Elton John; Sgt. Floyd Pepper is based on the Beatles\'s Sgt. Pepper album, and the original concept for Janice was a skinny, long-haired male character based on Mick Jagger. Animal, on the other hand, was designed by Jim Henson, and the rough sketch (also seen in Of Muppets and Men) doesn\'t appear to be related to any real musician.  However, it\'s not surprising that Animal is often compared with famous drummers -- as Buddy Rich said in his Muppet Show episode, \"All drummers are animals.\""
client.hmset "Beaker", "id", "2", "name", "Beaker", "profile", "Prior to Beaker\'s debut, Dr. Honeydew appeared in Muppet Labs segments by himself, but the timid assistant added a new level of comedy to the sketches. Dr. Honeydew\'s experiments and inventions always seem to go awry, and Beaker is their perpetual victim. He has been shrunk, cloned, deflated, turned invisible, and blown up, but he always comes back for more.  On The Muppet Show, Beaker has sung \"Feelings\" and, accompanied by The Swedish Chef and Animal, \"Danny Boy.\""
client.hmset "Piggy", "id", "3", "name", "Piggy", "profile", "From modest beginnings (which she is quick to gloss over), Miss Piggy first broke into show business by winning the Miss Bogen County beauty contest, a victory which also marked her first meeting with the frog of her life, Kermit (whom she often calls \"Kermie\"). The rest, as they say, is history (and a lot of juicy gossip, too).  In 1976, Miss Piggy started out in the chorus of The Muppet Show. Thanks to her charisma and a correspondence course in karate, Piggy made her presence known and soon became the lead chanteuse and femme fatale on the show. Quickly, her career expanded to include television specials, home videos, records and books. Her \"how to\" volume of advice on absolutely everything, Miss Piggy\'s Guide to Life, became a national bestseller, and her fabulous face has been featured on the cover of countless magazines too numerous to mention.  Miss Piggy starred in two regular Muppet Show sketches -- \"Veterinarian\'s Hospital\", as the ravishing Nurse Piggy, and \"Pigs in Space\", as the enchanting First Mate Piggy.  She also has a dog named Foo-Foo."
client.hmset "Kermit", "id", "4", "name", "Kermit", "profile", "Kermit the Frog, arguably Jim Henson\'s most famous Muppet creation, was the star and host of The Muppet Show, played a significant role on Sesame Street, and served as the logo of the Jim Henson Company. He continues to star in Muppet movies and make numerous TV appearances.  Kermit grew up with thousands of siblings, and has talked occasionally about other members of his family. His childhood adventures were chronicled in the 2002 video Kermit\'s Swamp Years. Kermit also has a nephew named Robin.  Miss Piggy insists that she and Kermit got married in The Muppets Take Manhattan and that they\'re very happy. Kermit disagrees, claiming that it was just a movie and that in real life, they have a \"professional relationship.\" (Meaning he thinks they\'re professionals and she thinks they\'re in a relationship.)  Kermit\'s most well-known catchphrase is \"Hi-ho, Kermit the Frog here!\" He typically introduced acts on The Muppet Show by waving his arms wildly and shouting \"Yaaaay!\" (a technique he learned from his old acting coach, Mr. Dawson).  Kermit has been credited as the writer of three books: For Every Child, A Better World; One Frog Can Make a Difference; and Before You Leap.\'"


# profile = [
#  'Animal is the drummer on The Muppet Show, performing with Dr. Teeth and the Electric Mayhem. Animal is a crazed percussionist with three styles of music -- loud, louder, and deafening. He speaks in a guttural shout, often repeating a few simple phrases, such as "BEAT DRUMS! BEAT DRUMS!" or "WO-MAN!" In relatively calmer moods, he is capable of more coherent conversation, but these instances are infrequent.
#   Animal first appeared in the 1975 pilot, The Muppet Show: Sex and Violence, chained up in a basement cell when he wasn\'t onstage performing with the Electric Mayhem. He later became a main character on The Muppet Show, and his unrestrained style has made him popular with young people for decades.
#   Frank Oz says that he had his character down to five words: Sex, sleep, food, drums and pain. Occasionally, two of those essentials, food and drums, are interchangeable. In The Muppet Movie, Dr. Teeth had to remind Animal to beat, and not eat, his drums. In The Muppet Show episode 110, when asked by Kermit if he preferred drumming to food, Animal replied that drums are food.
#   Animal\'s wild attitude can be compared to Cookie Monster. In A Muppet Family Christmas, after observing Cookie Monster eating all of Janice\'s cookies in his signature manner, Animal comments, "That my kind of fella!"
#   Animal\'s family life is generally non-existent, and outside of the band, the Muppet Show troupe, and women in general, he has no other relationships. A significant exception is depicted in the book The Case of the Missing Mother, which reveals the existence of Animal\'s mother, LaVerne. LaVerne is also a drummer, and it\'s implied that percussion skills are a family trait.
#   It is a popular legend that Animal was inspired by Keith Moon, the wild drummer of the Who.  Mick Fleetwood of Fleetwood Mac is also sometimes cited as the inspiration for Animal.  However, there is no evidence in the original sketches for the character that suggest that he was based on anybody in particular.
#   Three of the other members of the Electric Mayhem were created by Muppet designer Michael K. Frith, and the sketches reproduced in the 1981 book Of Muppets and Men show that they were based on famous musicians. Dr. Teeth is a cross between Dr. John and Elton John; Sgt. Floyd Pepper is based on the Beatles\' Sgt. Pepper album, and the original concept for Janice was a skinny, long-haired male character based on Mick Jagger. Animal, on the other hand, was designed by Jim Henson, and the rough sketch (also seen in Of Muppets and Men) doesn\'t appear to be related to any real musician.
#   However, it\'s not surprising that Animal is often compared with famous drummers -- as Buddy Rich said in his Muppet Show episode, "All drummers are animals."',
#  'Prior to Beaker\'s debut, Dr. Honeydew appeared in Muppet Labs segments by himself, but the timid assistant added a new level of comedy to the sketches. Dr. Honeydew\'s experiments and inventions always seem to go awry, and Beaker is their perpetual victim. He has been shrunk, cloned, deflated, turned invisible, and blown up, but he always comes back for more.
#   On The Muppet Show, Beaker has sung "Feelings" and, accompanied by The Swedish Chef and Animal, "Danny Boy."',
#  'From modest beginnings (which she is quick to gloss over), Miss Piggy first broke into show business by winning the Miss Bogen County beauty contest, a victory which also marked her first meeting with the frog of her life, Kermit (whom she often calls "Kermie"). The rest, as they say, is history (and a lot of juicy gossip, too).
#   In 1976, Miss Piggy started out in the chorus of The Muppet Show. Thanks to her charisma and a correspondence course in karate, Piggy made her presence known and soon became the lead chanteuse and femme fatale on the show. Quickly, her career expanded to include television specials, home videos, records and books. Her "how to" volume of advice on absolutely everything, Miss Piggy\'s Guide to Life, became a national bestseller, and her fabulous face has been featured on the cover of countless magazines too numerous to mention.
#   Miss Piggy starred in two regular Muppet Show sketches -- "Veterinarian\'s Hospital", as the ravishing Nurse Piggy, and "Pigs in Space", as the enchanting First Mate Piggy.
#   She also has a dog named Foo-Foo.',
#  'Kermit the Frog, arguably Jim Henson\'s most famous Muppet creation, was the star and host of The Muppet Show, played a significant role on Sesame Street, and served as the logo of the Jim Henson Company. He continues to star in Muppet movies and make numerous TV appearances.
#   Kermit grew up with thousands of siblings, and has talked occasionally about other members of his family. His childhood adventures were chronicled in the 2002 video Kermit\'s Swamp Years. Kermit also has a nephew named Robin.
#   Miss Piggy insists that she and Kermit got married in The Muppets Take Manhattan and that they\'re very happy. Kermit disagrees, claiming that it was just a movie and that in real life, they have a "professional relationship." (Meaning he thinks they\'re professionals and she thinks they\'re in a relationship.)
#   Kermit\'s most well-known catchphrase is "Hi-ho, Kermit the Frog here!" He typically introduced acts on The Muppet Show by waving his arms wildly and shouting "Yaaaay!" (a technique he learned from his old acting coach, Mr. Dawson).
#   Kermit has been credited as the writer of three books: For Every Child, A Better World; One Frog Can Make a Difference; and Before You Leap.'
# ]

