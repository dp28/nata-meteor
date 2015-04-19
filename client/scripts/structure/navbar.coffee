Template.navbar.events
  'click #sidebar-toggle': ->
    $('body').toggleClass 'sidebar-open'

  'click #login-buttons-logout': ->
    Router.go 'public'