BOUNDARIES = [
  [null, 2]
  [768, 3]
  [992, 5]
  [1200, 7]
]

buildQuery = (min, max) ->
  minQuery = if min? then "(min-width: #{min}px)" else ''
  maxQuery = if max? then "(max-width: #{max}px)" else ''
  join = if min? and max? then ' and ' else ''
  "#{minQuery}#{join}#{maxQuery}"

setMaxExpansionByQuery = (queryString, maxExpansion) ->
  mediaQuery = window.matchMedia queryString
  listener = ({matches}) ->
    Session.set 'maxExpansion', maxExpansion if matches

  mediaQuery.addListener listener
  listener mediaQuery

setupMaxExanpansionLevel = ->
  index = 0
  for [size, level], i in BOUNDARIES
    nextSize = if i is BOUNDARIES.length - 1 then null else BOUNDARIES[++index][0]
    setMaxExpansionByQuery buildQuery(size, nextSize), level

Meteor.startup ->
  setupMaxExanpansionLevel()
