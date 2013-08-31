module.exports = class LightbotProgram
  constructor: (@procs, @cur_proc='main', @pc=0) ->

  state: -> "#{@cur_proc}[#{@pc}]"

  next: -> @procs[@cur_proc][@pc]

  increment: -> @pc++

  callProc: (proc) ->
    @cur_proc = proc
    @pc       = 0
