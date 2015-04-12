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
    submit target
    false

  'change .hide-completed input': ({target}) ->
    Session.set 'hideCompleted', target.checked

  'keyup .new-task': ({target}) ->
    share.wrapTextareaHeight target

  'keydown .new-task': (event) ->
    if event.which is 13
      event.preventDefault()
      submit event.target
      share.wrapTextareaHeight event.target

submit = (textarea) ->
  Meteor.call 'addTask', textarea.value
  textarea.value = ''
