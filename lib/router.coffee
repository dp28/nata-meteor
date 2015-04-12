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

  @route 'home', path: '/'
  @route 'notFound', path: '*'


