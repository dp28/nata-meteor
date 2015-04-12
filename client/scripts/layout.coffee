Template.layout.events
  'click .navbar-toggle': ({target}) ->
    $('.row-offcanvas').toggleClass 'active'

  'change .hide-completed input': ({target}) ->
    Session.set 'hideCompleted', target.checked

  'click #login-buttons-logout': ->
    Router.go 'public'