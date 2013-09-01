_ = require 'underscore'

module.exports = class LightbotSquare
  constructor: ({@color, @goal, @elev, @tagged, @lift}={}) ->
    @elev ?= 0
