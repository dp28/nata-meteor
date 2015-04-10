share.Tasks = new Mongo.Collection 'tasks'

Meteor.methods(
  addTask: (text) ->
    throw new Meteor.Error 'not-authorized' unless Meteor.userId()
    share.Tasks.insert
      text: text
      createdAt: new Date()
      owner: Meteor.userId()
      username: Meteor.user().username

  deleteTask: (taskId) ->
    share.Tasks.remove taskId

  setChecked: (taskId, checked) ->
    share.Tasks.update taskId, $set: checked: checked
)