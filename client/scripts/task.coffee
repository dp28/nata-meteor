Template.task.events
  'click .toggle-checked': ->
    Meteor.call 'updateTask', @_id, checked: not @checked

  'click .delete': ->
    Meteor.call 'deleteTask', @_id

  'click .toggle-private': ->
    Meteor.call 'updateTask', @_id, private: not @private

  'keyup .text-field': _.throttle ({target}) ->
    wrapHeight target
    Meteor.call 'updateTask', @_id, text: target.value
  , 300

  'click .expand': _.throttle ->
    key = "expanded#{@_id}"
    Session.set key, if Session.get key then false else true
  , 300, trailing: false

Template.task.helpers
  isOwner: ->
    @owner is Meteor.userId()

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