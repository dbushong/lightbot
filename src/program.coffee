module.exports = class LightbotProgram
  constructor: (@procs, @cur_proc='main', @pc=0) ->
    @callers = []

  state: -> "#{@cur_proc}[#{@pc}]"

  next: -> @procs[@cur_proc][@pc]

  increment: ->
    @pc++
    while @callers.length and not @next()
      [ @cur_proc, @pc ] = @callers.pop()
      @pc++

  callProc: (p) ->
    @callers.push [ @cur_proc, @pc ]
    @cur_proc = p
    @pc       = 0
