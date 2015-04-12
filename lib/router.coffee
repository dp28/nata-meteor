Router.configure
  layoutTemplate: 'layout'
  notFoundTemplate: 'notFound'
  loadingTemplate: 'loading'

Router.map ->
  @route 'listsShow',
    path: '/lists/:_id'
    data: -> share.Tasks.findOne @params._id
    onBeforeAction: ->
      Meteor.subscribe 'children', @params._id
      @next()

  @route 'profile', path: 'profile'
  @route 'public', path: 'public'

  @route 'home',
    path: '/'
    action: ->
      Router.go if Meteor.userId() then 'profile' else 'public'

  @route 'notFound', path: '*'


