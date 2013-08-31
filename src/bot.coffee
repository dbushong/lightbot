module.exports = class LightbotBot
  constructor: (@x, @y, @dir, @color=null) ->

  state: -> [@x, @y, @dir ? 0, @color ? 'none'].join(',')

  turnRight: -> @dir = (@dir + 1) % 4

  turnLeft:  -> @dir = (@dir - 1) % 4

  moveTo: (@x, @y) ->
