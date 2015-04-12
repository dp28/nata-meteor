CONNECTION_ISSUE_TIMEOUT = 3000
SHOW_CONNECTION_ISSUE_KEY = 'showConnectionIssue'

Meteor.startup ->
  setTimeout ->
    Session.set SHOW_CONNECTION_ISSUE_KEY, true
  , CONNECTION_ISSUE_TIMEOUT

Template.notifications.helpers
  connected: ->
    if Session.get SHOW_CONNECTION_ISSUE_KEY
      Meteor.status().connected
    else
      true