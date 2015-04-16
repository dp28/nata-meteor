Meteor.startup ->
  $(document.body).touchwipe
    wipeLeft: ->
      $('body').removeClass 'sidebar-open'

    wipeRight: ->
      unless $('body').hasClass 'sidebar-open'
        $('body').addClass 'sidebar-open'

    preventDefaultEvents: false
