Template.home.helpers
  rootLists: ->
    if Session.get 'hideCompleted'
      share.Tasks.find {parentId: null, checked: $ne: true}, sort: createdAt: -1
    else
      share.Tasks.find {parentId: null}, sort: createdAt: -1
