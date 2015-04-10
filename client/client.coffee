Template.body.helpers(
  tasks: ->
    if Session.get 'hideCompleted'
      share.Tasks.find {checked: $ne: true}, sort: createdAt: -1
    else
      share.Tasks.find {}, sort: createdAt: -1

  hideCompleted: ->
    Session.get 'hideCompleted'

  incompleteCount: ->
    share.Tasks.find(checked: $ne: true).count()
)

Template.body.events(
  'submit .new-task': ({target}) ->
    text = target.text.value
    share.Tasks.insert { text: text, createdAt: new Date() }
    target.text.value = ''
    false

  'change .hide-completed input': ({target}) ->
    Session.set 'hideCompleted', target.checked
)