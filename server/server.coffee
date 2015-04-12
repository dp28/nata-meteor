Meteor.publish 'tasks', ->
  share.Tasks.find
    $or: [
      { private: {$ne: true} },
      { owner: @userId }
    ]