Template.hello.helpers counter: ->
  Session.get 'counter'

Template.hello.events 'click button': ->
  Session.set 'counter', Session.get('counter') + 1