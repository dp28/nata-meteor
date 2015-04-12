Template.home.helpers
  ownedList: ->
    share.Tasks.findOne owner: Meteor.userId()
