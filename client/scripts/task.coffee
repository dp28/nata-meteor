Template.task.events
  'click .toggle-checked': (event) ->
    event.stopImmediatePropagation()
    Meteor.call 'updateTask', @_id, checked: not @checked

  'keyup .edit-task .text-field': _.throttle (event) ->
    event.stopImmediatePropagation()
    wrapHeight event.target
    Meteor.call 'updateTask', @_id, text: event.target.value
  , 300

  'click .expand': (event) ->
    event.stopImmediatePropagation()
    handleExpand @ if toggleExpand @_id

  'keydown .new-task': (event) ->
    event.stopImmediatePropagation()
    if event.which is 13
      event.preventDefault()
      Meteor.call 'addTask', @_id, event.target.value
      event.target.value = ''
      wrapHeight event.target

Template.task.helpers
  children: ->
    taskSearch parentId: @_id

  expanded: ->
    Session.get('expanded')?[@_id]

  childCount: ->
    childCount @_id

  hasChildren: ->
    childCount(@_id) > 0

Template.task.onRendered ->
  wrapHeight $(@firstNode).find('.text-field')[0]

childCount = (id) ->
  share.Tasks.find(parentId: id).count()

wrapHeight = (element) ->
  element.style.height = 'auto'
  element.style.height = "#{element.scrollHeight}px"

taskSearch = (search) ->
  search.checked = $ne: true if Session.get 'hideCompleted'
  share.Tasks.find search, sort: createdAt: -1

toggleExpand = (id) ->
  expandedIds = Session.get('expanded') or {}
  expandedIds[id] = if expandedIds[id] then false else true
  Session.set 'expanded', expandedIds
  expandedIds[id]

handleExpand = (task) ->
  expandFurthest task.ancestors if fullyExpanded task.ancestors.length

expandFurthest = (taskIds) ->
  level = taskIds.length - (Session.get('maxExpansion') - 1)
  console.log taskIds[level]
  Router.go 'listsShow', {_id: taskIds[level]}, query: keepExpanded: true

fullyExpanded = (taskDepth) ->
  depthDifference = taskDepth - Session.get 'currentDepth'
  console.log depthDifference + 1, Session.get('maxExpansion'), depthDifference + 1 >= Session.get 'maxExpansion'
  depthDifference + 1 >= Session.get 'maxExpansion'

share.wrapTextareaHeight = wrapHeight
share.taskSearch = taskSearch