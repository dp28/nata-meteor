Template.profile.helpers
  rootLists: ->
    share.taskSearch parentId: null, owner: Meteor.userId()

Template.profile.events
  'keyup .new-task': (event) ->
    share.wrapTextareaHeight event.target

  'keydown .new-task': (event) ->
    if event.which is 13
      event.preventDefault()
      Meteor.call 'addTask', null, event.target.value
      event.target.value = ''

