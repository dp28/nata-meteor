Template.registerHelper 'formatDate', (date) ->
  new DateFormatter(date).fromNow()

class DateFormatter

  SECOND = 1000
  MINUTE = 60 * SECOND
  HOUR = 60 * MINUTE
  DAY = 24 * HOUR

  constructor: (@date) ->

    @between = (start, end) =>
      @difference >= start and @difference < end

    @round = (unit) =>
      Math.floor @difference / unit

  fromNow: ->
    return ': unknown' unless @date instanceof Date
    @difference = new Date() - @date
    switch
      when @between 0, 10 * SECOND then ' seconds ago'
      when @between 10 * SECOND, MINUTE then " #{@round SECOND} seconds ago"
      when @between MINUTE, 2 * MINUTE then " 1 minute ago"
      when @between 2 * MINUTE, HOUR then " #{@round MINUTE} minutes ago"
      when @between HOUR, 2 * HOUR then " 1 hour ago"
      when @between 2 * HOUR, DAY then " #{@round HOUR} hours ago"
      when @between DAY, 2 * DAY then " yesterday"
      when @between 2 * DAY, 4 * DAY then "#{@round DAY} days ago"
      else ": #{@date.toDateString()}"

