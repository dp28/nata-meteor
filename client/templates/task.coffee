Template.task.events(
  'click .toggle-checked': ->
    share.Tasks.update @_id, $set: checked: not @checked

  'click .delete': ->
    share.Tasks.remove @_id
)