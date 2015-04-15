Template.layout.events
  'click #sidebar-toggle': ({target}) ->
    $('body').toggleClass 'sidebar-open'

  'click .hide-completed': ->
    Session.set 'hideCompleted', not Session.get 'hideCompleted'

  'click #login-buttons-logout': ->
    Router.go 'public'

Template.layout.helpers

  hideCompleted: ->
    Session.get 'hideCompleted'