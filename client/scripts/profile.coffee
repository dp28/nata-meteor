Template.profile.helpers
  rootLists: ->
    share.taskSearch parentId: null, owner: Meteor.userId()
