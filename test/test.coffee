#need to write tests
exports.run = ->
  test 'text', ->
    'text' is render ->
      text 'text'

  puts "\nTests: #{tests.length} | Passed: #{passed.length} | Failed: #{failed.length} | Errors: #{errors.length}"

puts = console.log
print = require('sys').print
ck = require 'coffeekup'
render = ck.render

[tests, passed, failed, errors] = [[], [], [], []]

test = (name, code) ->
  tests.push name
  print "Testing \"#{name}\"... "
  try
    if code()
      passed.push name
      puts "[OK]"
    else
      failed.push name
      puts "[Failed]"
  catch ex
    errors.push name
    puts "[Error] \"#{ex.message}\""

