Template.task.events
  'click .toggle-checked': (event) ->
    event.stopImmediatePropagation()
    Meteor.call 'updateTask', @_id, checked: not @checked

  'click .delete': (event) ->
    event.stopImmediatePropagation()
    Meteor.call 'deleteTask', @_id

  'keyup .edit-task .text-field': _.throttle (event) ->
    event.stopImmediatePropagation()
    wrapHeight event.target
    Meteor.call 'updateTask', @_id, text: event.target.value
  , 300

  'click .expand': (event) ->
    event.stopImmediatePropagation()
    key = "expanded#{@_id}"
    Session.set key, if Session.get key then false else true

  'keydown .new-task': (event) ->
    event.stopImmediatePropagation()
    if event.which is 13
      event.preventDefault()
      Meteor.call 'addTask', @_id, event.target.value
      event.target.value = ''
      wrapHeight event.target

Template.task.helpers
  children: ->
    if Session.get 'hideCompleted'
      share.Tasks.find {parentId: @_id, checked: $ne: true}, sort: createdAt: -1
    else
      share.Tasks.find {parentId: @_id}, sort: createdAt: -1

  expanded: ->
    Session.get "expanded#{@_id}"

wrapHeight = (element) ->
  element.style.height = 'auto'
  element.style.height = "#{element.scrollHeight}px"

share.wrapTextareaHeight = wrapHeight

Template.task.onRendered ->
  wrapHeight $(@firstNode).find('.text-field')[0]