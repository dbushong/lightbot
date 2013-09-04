module.exports = class LightbotSquare
  constructor: ({@color, @goal, @elev, @tagged, @lift, @warp}={}) ->
    @elev ?= 0
