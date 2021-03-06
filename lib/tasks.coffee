Tasks = new Mongo.Collection 'tasks'
share.Tasks = Tasks

Meteor.methods
  addTask: (parentId, text) ->
    authorizedIf Meteor.userId()
    parent = Tasks.findOne(_id: parentId)
    ancestors = parent?.ancestors ? []
    ancestors.push parentId if parentId
    Tasks.insert
      text: text
      parentId: parentId
      ancestors: ancestors
      private: parent?.private ? true
      createdAt: new Date()
      updatedAt: new Date()
      owner: Meteor.userId()
      username: Meteor.user().username

  updateTask: (taskId, change) ->
    authorizedIf currentUserCanEdit taskId
    change.updatedAt = new Date()
    Tasks.update taskId, $set: change

  deleteTask: (taskId) ->
    authorizedIf currentUserCanEdit taskId
    Tasks.remove taskId

authorizedIf = (authorized) ->
  throw new Meteor.Error 'not-authorized' unless authorized

currentUserCanEdit = (taskId) ->
  task = Tasks.findOne taskId
  if task.private then task.owner is Meteor.userId() else Meteor.userId()?