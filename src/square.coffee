_ = require 'underscore'

module.exports = class LightbotSquare
  constructor: ({@color, @goal, @elev, @tagged, @lift}={}) ->
    @elev   ?= 0
    @goal   ?= true
    @tagged ?= false
    @lift   ?= false

    @goal   = false     if @color or @lift
    @color  = null      if @goal
    @tagged = false unless @goal
