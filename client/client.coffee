Meteor.subscribe 'tasks'

Accounts.ui.config passwordSignupFields: 'USERNAME_ONLY'

addTouchwipe = ->
  $(document.body).touchwipe
    wipeLeft: ->
      $('.row-offcanvas').removeClass 'active'

    wipeRight: ->
      unless $('.row-offcanvas').hasClass 'active'
        $('.row-offcanvas').addClass 'active'

    preventDefaultEvents: false


Meteor.startup ->
  addTouchwipe()
