actions = [ 'forward', 'right', 'left', 'jump', 'bulb' ]
colors  = [ 'green', 'red' ]

module.exports = class LightbotInstruction
  constructor: (@action, @color=null) ->
    throw new Error("invalid action: #{@action}") unless @action in actions
    if @color? and not @color in colors
      throw new Error("invalid color: #{@color}")

