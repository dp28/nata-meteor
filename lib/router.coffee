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
      depth = share.Tasks.findOne(@params._id)?.ancestors.length + 1 or 0
      Session.set 'currentDepth', depth
      @next()

    action: ->
      Session.set 'expanded', {} unless @params.query.keepExpanded
      @render()

  @route 'profile',
    path: 'profile'
    onBeforeAction: ->
      Session.set 'expanded', {}
      Session.set 'currentDepth', 0
      @next()

  @route 'public',
    path: 'public'
    onBeforeAction: ->
      Session.set 'expanded', {}
      Session.set 'currentDepth', 0
      @next()

  @route 'home',
    path: '/'
    action: ->
      Router.go if Meteor.userId() then 'profile' else 'public'

  @route 'notFound', path: '*'


