actions = [ 'forward', 'right', 'left', 'jump', 'bulb', 'p1', 'p2', 'return' ]
colors  = [ 'green', 'red' ]

module.exports = class LightbotInstruction
  constructor: (@action, @color=null) ->
    throw new Error("invalid action: #{@action}") unless @action in actions
    if @color? and not @color in colors
      throw new Error("invalid color: #{@color}")

  draw: ->
    line = @action
    line = "[#{if @color is 'red' then 31 else 32}m#{line}[0m" if @color
    console.log line
