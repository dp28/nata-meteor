Template.task.events
  'click .toggle-checked': ->
    Meteor.call 'setChecked', @_id, not @checked

  'click .delete': ->
    Meteor.call 'deleteTask', @_id

  'click .toggle-private': ->
    Meteor.call 'setPrivate', @_id, not @private

Template.task.helpers
  isOwner: ->
    @owner is Meteor.userId()