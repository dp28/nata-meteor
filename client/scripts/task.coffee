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

  'ready .text-field': ({target}) ->
    console.log target

Template.task.helpers
  isOwner: ->
    @owner is Meteor.userId()

wrapHeight = (element) ->
  element.style.height = "#{element.scrollHeight}px"

Template.task.onRendered ->
  wrapHeight $(@firstNode).find('.text-field')[0]