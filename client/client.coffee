Template.body.helpers tasks: -> share.Tasks.find {}, sort: createdAt: -1

Template.body.events 'submit .new-task': ({target}) ->
  text = target.text.value
  share.Tasks.insert { text: text, createdAt: new Date() }
  target.text.value = ''
  false