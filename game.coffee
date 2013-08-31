_ = require 'underscore'

module.exports = class LightBotGame
  constructor: (@board, @bot, @prog) ->
    @ended  = false
    @looped = false
    @goals  = []
    @seen   = {}
    @eachSquare (sq) => @goals.push sq if sq.goal

  eachSquare: (fn) ->
    for row in @board
      for square in row
        fn square
    null

  won: -> _.all @goals, (g) -> g.tagged

  lost: -> @ended or @looped
  
  over: -> @won() or @lost()

  tick: ->
    instr = @prog.next()
    unless instr?
      @ended = true
      return null

    @execute instr

    state = @state()
    @looped = true if @seen[state]
    @seen[state] = true

  state: ->
    board_state = @goals.map((g) -> if g.tagged then 'y' else 'n').join('')
    board_state + '/' + @prog.state() + '/' + @bot.state()

  draw: ->
    console.log '----------'
    for row, y in @board
      chars = row.map (square, x) =>
        attrs = []
        char  =
          if x is @bot.x and y is @bot.y
            ['^', '>', 'v', '<'][@bot.dir]
          else
            square.elev
        attrs.push 31 if @bot.color is 'red'
        attrs.push 32 if @bot.color is 'green'
        attrs.push 41 if square.color is 'red'
        attrs.push 42 if square.color is 'green'
        attrs.push 1 if square.goal
        attrs.push 4 if square.tagged
        char = "[#{attrs.join(';')}m#{char}[0m" if attrs.length
        char

      console.log chars.join ''

  execute: (instr) ->
    unless instr.color and (instr.color isnt @bot.color)
      square = @board[@bot.y][@bot.x]

      switch instr.action
        when 'p1', 'p2'
          @prog.callProc instr.action
          return
        when 'forward', 'jump'
          [y, x] = switch @bot.dir
            when 0 then [@bot.y-1, @bot.x]
            when 1 then [@bot.y, @bot.x+1]
            when 2 then [@bot.y+1, @bot.x]
            when 3 then [@bot.y, @bot.x-1]
          next = @board[y]?[x]
          if next
            if instr.action is 'forward'
              @bot.moveTo x, y if next.elev is square.elev
            else # if instr.action is 'jump'
              @bot.moveTo x, y if Math.abs(next.elev - square.elev) is 1
        when 'bulb'
          square = @board[@bot.y][@bot.x]
          if square.goal
            square.tagged = not square.tagged
          else if square.color
            @bot.color =
              if @bot.color is square.color then null else square.color
        when 'right'
          @bot.turnRight()
        when 'left'
          @bot.turnLeft()

    @prog.increment()
