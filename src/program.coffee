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

  returnFromProc: ->
    if @callers.length
      [ @cur_proc, @pc ] = @callers.pop()
      @pc++
    else
      @pc = @procs[@cur_proc].length - 1 # put us at the end of main

  callProc: (p) ->
    @callers.push [ @cur_proc, @pc ]
    @cur_proc = p
    @pc       = 0
