Template.task.events
  'click .toggle-checked': ->
    Meteor.call 'setChecked', @_id, not @checked

  'click .delete': ->
    Meteor.call 'deleteTask', @_id

  'click .toggle-private': ->
    Meteor.call 'setPrivate', @_id, not @private

  'keydown input[type=text]': (event)->
    if event.which is 13
      event.preventDefault()
      event.target.blur()

  'keyup input[type=text]': _.throttle ({target}) ->
    Meteor.call 'updateTask', @_id, text: target.value
  , 300

Template.task.helpers
  isOwner: ->
    @owner is Meteor.userId()