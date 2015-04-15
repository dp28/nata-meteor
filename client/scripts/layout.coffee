Template.layout.events
  'click .navbar-toggle': ({target}) ->
    $('.row-offcanvas').toggleClass 'active'

  'click .hide-completed': ->
    Session.set 'hideCompleted', not Session.get 'hideCompleted'

  'click #login-buttons-logout': ->
    Router.go 'public'

Template.layout.helpers

  hideCompleted: ->
    Session.get 'hideCompleted'