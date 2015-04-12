Template.public.helpers
  publicLists: ->
    share.taskSearch parentId: null, private: $ne: true
