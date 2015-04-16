Template.sidebar.events
  'click .hide-completed': ->
    Session.set 'hideCompleted', not Session.get 'hideCompleted'

  'click #login-buttons-logout': ->
    Router.go 'public'

Template.sidebar.helpers

  hideCompleted: ->
    Session.get 'hideCompleted'