Template.navbar.events
  'click #sidebar-toggle': ->
    console.log 'here'
    $('body').toggleClass 'sidebar-open'