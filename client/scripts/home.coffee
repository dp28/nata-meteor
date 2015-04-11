Template.home.helpers
  tasks: ->
    if Session.get 'hideCompleted'
      share.Tasks.find {checked: $ne: true}, sort: createdAt: -1
    else
      share.Tasks.find {}, sort: createdAt: -1

  hideCompleted: ->
    Session.get 'hideCompleted'

  incompleteCount: ->
    share.Tasks.find(checked: $ne: true).count()

Template.home.events
  'submit .new-task': ({target}) ->
    Meteor.call 'addTask', target.text.value
    target.text.value = ''
    false

  'change .hide-completed input': ({target}) ->
    Session.set 'hideCompleted', target.checked