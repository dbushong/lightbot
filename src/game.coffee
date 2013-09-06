Square = require './square'
Bot    = require './bot'
Instr  = require './instruction'
Prog   = require './program'
{EventEmitter} = require 'events'

module.exports = class LightbotGame extends EventEmitter
  constructor: (@board, @bot, @prog) ->
    @ended  = false
    @looped = false
    @goals  = []
    @seen   = {}
    @eachSquare (sq) => @goals.push sq if sq.goal

  @load: (data) ->
    board = data.board
    for row in board
      for square, i in row
        row[i] = new Square square

    bot = new Bot data.bot.x, data.bot.y, data.bot.dir, data.bot.color

    for proc, instrs of data.prog
      data.prog[proc] = instrs.map (instr) ->
        new Instr instr.action, instr.color
    prog = new Prog data.prog

    new LightbotGame board, bot, prog

  eachSquare: (fn) ->
    for row in @board
      for square in row
        fn square
    null

  won: -> @goals.filter((g) -> g.tagged).length is @goals.length

  lost: -> @ended or @looped
  
  over: -> @won() or @lost()

  tick: ->
    return null if @over()

    instr = @prog.next()
    unless instr?
      @ended = true
      @emit 'gameOver', 'ended'
      return null

    @execute instr

    state = @state()
    if @seen[state]
      @looped = true
      @emit 'gameOver', 'looped'
    @seen[state] = true

    @emit 'gameOver', 'won' if @won()

    instr

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
            attrs.push 31 if @bot.color is 'red'
            attrs.push 32 if @bot.color is 'green'
            ['^', '>', 'v', '<'][@bot.dir]
          else
            square.elev
        attrs.push 41 if square.color is 'red'
        attrs.push 42 if square.color is 'green'
        attrs.push 1 if square.goal
        attrs.push 4 if square.tagged
        attrs.push 7 if square.lift
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
              @emit 'moveBot', x, y
            else # if instr.action is 'jump'
              diff = next.elev - square.elev
              # can jump up 1 or down any
              if diff is 1 or diff < 0
                @bot.moveTo x, y
                @emit 'moveBot', x, y
        when 'bulb'
          @emit 'bulbBot'
          square = @board[@bot.y][@bot.x]
          if square.goal
            square.tagged = not square.tagged
            @emit 'toggleGoal', @bot.x, @bot.y, square.tagged
          else if square.color
            @bot.color =
              if @bot.color is square.color then null else square.color
            @emit 'botChangeColor', @bot.color
          else if square.lift
            square.elev = switch square.elev
              when 0 then 2
              when 2 then 4
              when 4 then 0
              else throw "invalid lift elevation: #{square.elev}"
            @emit 'liftMove', @bot.x, @bot.y, square.elev
          else if square.warp
            @bot.moveTo square.warp...
            @emit 'moveBot', square.warp...
        when 'right'
          @bot.turnRight()
          @emit 'turnBot', @bot.dir
        when 'left'
          @bot.turnLeft()
          @emit 'turnBot', @bot.dir
        when 'return'
          @prog.returnFromProc()

    @prog.increment()
