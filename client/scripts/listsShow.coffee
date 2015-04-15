Template.listsShow.helpers
  isOwner: ->
    @owner is Meteor.userId()

  tasks: ->
    if Session.get 'hideCompleted'
      share.Tasks.find {parentId: @_id, checked: $ne: true}, sort: createdAt: -1
    else
      share.Tasks.find {parentId: @_id}, sort: createdAt: -1

  canDelete: ->
    Meteor.userId()? and (not @private or Meteor.userId() is @owner)

Template.listsShow.events
  'submit .new-task': ({target}) ->
    submit target, @_id
    false

  'click .delete': (event) ->
    event.stopImmediatePropagation()
    parentId = @parentId
    deleteAll @_id
    Router.go 'listsShow', _id: parentId

  'keyup .new-task': ({target}) ->
    share.wrapTextareaHeight target

  'click .toggle-private': (event) ->
    event.stopImmediatePropagation()
    Meteor.call 'updateTask', @_id, private: not @private

  'keydown .new-task': (event) ->
    if event.which is 13
      event.preventDefault()
      submit event.target, @_id
      share.wrapTextareaHeight event.target

  'keyup .edit-list .text-field': _.throttle (event) ->
    event.stopImmediatePropagation()
    share.wrapTextareaHeight event.target
    Meteor.call 'updateTask', @_id, text: event.target.value
  , 300

submit = (textarea, id) ->
  Meteor.call 'addTask', id, textarea.value
  textarea.value = ''

deleteAll = (id) ->
  for task in share.Tasks.find(parentId: id).fetch()
    deleteAll task._id if Meteor.userId() is task.owner or not task.private
  Meteor.call 'deleteTask', id