Meteor.subscribe 'tasks'

Accounts.ui.config passwordSignupFields: 'USERNAME_ONLY'

addTouchwipe = ->
  $(document.body).touchwipe
    wipeLeft: ->
      $('body').removeClass 'sidebar-open'

    wipeRight: ->
      unless $('body').hasClass 'sidebar-open'
        $('body').addClass 'sidebar-open'

    preventDefaultEvents: false

Meteor.startup ->
  addTouchwipe()
