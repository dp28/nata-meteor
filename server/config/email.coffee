gmail =
  username: 'not.another.todo.app'
  password: '!otrofaireconstabulary'

process.env.MAIL_URL = "smtp://#{gmail.username}%40gmail.com:#{gmail.password}@smtp.gmail.com:465/"

Meteor.startup ->
  name = share.Application.name

  Accounts.emailTemplates.from = "#{name} <#{gmail.username}@gmail.com>"
  Accounts.emailTemplates.siteName = name
  Accounts.emailTemplates.verifyEmail.subject = -> 'Confirm your email address'
  Accounts.emailTemplates.verifyEmail.text = (user, url) ->
    "Click on the following link to confirm your email address #{url}."

Accounts.onCreateUser (options, user) ->
  Meteor.setTimeout ->
    Accounts.sendVerificationEmail user._id
  , 2000
  user