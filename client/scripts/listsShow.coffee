Template.listsShow.helpers
  tasks: ->
    if Session.get 'hideCompleted'
      share.Tasks.find {parentId: @_id, checked: $ne: true}, sort: createdAt: -1
    else
      share.Tasks.find {parentId: @_id}, sort: createdAt: -1

  hideCompleted: ->
    Session.get 'hideCompleted'

  incompleteCount: ->
    share.Tasks.find(parentId: @_id, checked: $ne: true).count()

Template.listsShow.events
  'submit .new-task': ({target}) ->
    submit target, @_id
    false

  'change .hide-completed input': ({target}) ->
    Session.set 'hideCompleted', target.checked

  'keyup .new-task': ({target}) ->
    share.wrapTextareaHeight target

  'keydown .new-task': (event) ->
    if event.which is 13
      event.preventDefault()
      submit event.target, @_id
      share.wrapTextareaHeight event.target

submit = (textarea, id) ->
  Meteor.call 'addTask', id, textarea.value
  textarea.value = ''
