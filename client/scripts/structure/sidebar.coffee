Template.sidebar.events
  'click .hide-completed': ->
    Session.set 'hideCompleted', not Session.get 'hideCompleted'

Template.sidebar.helpers

  hideCompleted: ->
    Session.get 'hideCompleted'