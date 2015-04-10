Template.task.events
  'click .toggle-checked': ->
    Meteor.call 'setChecked', @_id, not @checked

  'click .delete': ->
    Meteor.call 'deleteTask', @_id