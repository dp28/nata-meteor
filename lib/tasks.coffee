Tasks = new Mongo.Collection 'tasks'
share.Tasks = Tasks

Meteor.methods
  addTask: (text) ->
    authorizedIf Meteor.userId()
    Tasks.insert
      text: text
      createdAt: new Date()
      owner: Meteor.userId()
      username: Meteor.user().username


  updateTask: (taskId, change) ->
    task = Tasks.findOne taskId
    authorizedIf currentUserOwns task if task.private
    Tasks.update taskId, $set: change

  deleteTask: (taskId) ->
    task = Tasks.findOne taskId
    authorizedIf currentUserOwns task if task.private
    Tasks.remove taskId

  setChecked: (taskId, checked) ->
    task = Tasks.findOne taskId
    authorizedIf currentUserOwns task if task.private
    Tasks.update taskId, $set: checked: checked

  setPrivate: (taskId, setPrivate) ->
    task = Tasks.findOne taskId
    authorizedIf currentUserOwns task
    Tasks.update taskId, $set: private: setPrivate

authorizedIf = (authorized) ->
  throw new Meteor.Error 'not-authorized' unless authorized

currentUserOwns = (task) ->
  task.owner is Meteor.userId()