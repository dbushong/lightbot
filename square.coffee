_ = require 'underscore'

module.exports = class LightbotSquare
  constructor: ({@color, @goal, @elev, @tagged}={}) ->
    @elev   ?= 0
    @goal   ?= true
    @tagged ?= false
