_ = require 'underscore'

module.exports = class LightBotGame
  constructor: (@board, @bot, @prog) ->
    @lost  = false
    @goals = []
    @eachSquare (sq) => @goals.push sq if sq.goal

  eachSquare: (fn) ->
    for row in @board
      for square in row
        fn square
    null

  won: -> _.all @goals, (g) -> g.tagged
  
  over: -> @lost or @won()

  tick: ->
    instr = @prog.next()
    unless instr?
      @lost = true
      return null


