(function(e){if("function"==typeof bootstrap)bootstrap("lightbot",e);else if("object"==typeof exports)module.exports=e();else if("function"==typeof define&&define.amd)define(e);else if("undefined"!=typeof ses){if(!ses.ok())return;ses.makeLightbot=e}else"undefined"!=typeof window?window.Lightbot=e():global.Lightbot=e()})(function(){var define,ses,bootstrap,module,exports;
return (function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
// Generated by CoffeeScript 1.6.3
(function() {
  var LightbotBot;

  module.exports = LightbotBot = (function() {
    function LightbotBot(x, y, dir, color) {
      this.x = x;
      this.y = y;
      this.dir = dir;
      this.color = color != null ? color : null;
    }

    LightbotBot.prototype.state = function() {
      var _ref, _ref1;
      return [this.x, this.y, (_ref = this.dir) != null ? _ref : 0, (_ref1 = this.color) != null ? _ref1 : 'none'].join(',');
    };

    LightbotBot.prototype.turnRight = function() {
      return this.dir = (this.dir + 1) % 4;
    };

    LightbotBot.prototype.turnLeft = function() {
      return this.dir = (this.dir - 1) % 4;
    };

    LightbotBot.prototype.moveTo = function(x, y) {
      this.x = x;
      this.y = y;
    };

    return LightbotBot;

  })();

}).call(this);

},{}],2:[function(require,module,exports){
// Generated by CoffeeScript 1.6.3
(function() {
  var Bot, EventEmitter, Instr, LightbotGame, Prog, Square,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __slice = [].slice;

  Square = require('./square');

  Bot = require('./bot');

  Instr = require('./instruction');

  Prog = require('./program');

  EventEmitter = require('events').EventEmitter;

  module.exports = LightbotGame = (function(_super) {
    __extends(LightbotGame, _super);

    function LightbotGame(board, bot, prog) {
      var _this = this;
      this.board = board;
      this.bot = bot;
      this.prog = prog;
      this.ended = false;
      this.looped = false;
      this.goals = [];
      this.seen = {};
      this.eachSquare(function(sq) {
        if (sq.goal) {
          return _this.goals.push(sq);
        }
      });
    }

    LightbotGame.load = function(data) {
      var board, bot, i, instrs, proc, prog, row, square, _i, _j, _len, _len1, _ref;
      board = data.board;
      for (_i = 0, _len = board.length; _i < _len; _i++) {
        row = board[_i];
        for (i = _j = 0, _len1 = row.length; _j < _len1; i = ++_j) {
          square = row[i];
          row[i] = new Square(square);
        }
      }
      bot = new Bot(data.bot.x, data.bot.y, data.bot.dir, data.bot.color);
      _ref = data.prog;
      for (proc in _ref) {
        instrs = _ref[proc];
        data.prog[proc] = instrs.map(function(instr) {
          return new Instr(instr.action, instr.color);
        });
      }
      prog = new Prog(data.prog);
      return new LightbotGame(board, bot, prog);
    };

    LightbotGame.prototype.eachSquare = function(fn) {
      var row, square, _i, _j, _len, _len1, _ref;
      _ref = this.board;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        row = _ref[_i];
        for (_j = 0, _len1 = row.length; _j < _len1; _j++) {
          square = row[_j];
          fn(square);
        }
      }
      return null;
    };

    LightbotGame.prototype.won = function() {
      return this.goals.filter(function(g) {
        return g.tagged;
      }).length === this.goals.length;
    };

    LightbotGame.prototype.lost = function() {
      return this.ended || this.looped;
    };

    LightbotGame.prototype.over = function() {
      return this.won() || this.lost();
    };

    LightbotGame.prototype.tick = function() {
      var instr, state;
      if (this.over()) {
        return null;
      }
      instr = this.prog.next();
      if (instr == null) {
        this.ended = true;
        this.emit('gameOver', 'ended');
        return null;
      }
      this.execute(instr);
      state = this.state();
      if (this.seen[state]) {
        this.looped = true;
        this.emit('gameOver', 'looped');
      }
      this.seen[state] = true;
      if (this.won()) {
        this.emit('gameOver', 'won');
      }
      return instr;
    };

    LightbotGame.prototype.state = function() {
      var board_state;
      board_state = this.goals.map(function(g) {
        if (g.tagged) {
          return 'y';
        } else {
          return 'n';
        }
      }).join('');
      return board_state + '/' + this.prog.state() + '/' + this.bot.state();
    };

    LightbotGame.prototype.draw = function() {
      var chars, row, y, _i, _len, _ref, _results,
        _this = this;
      console.log('----------');
      _ref = this.board;
      _results = [];
      for (y = _i = 0, _len = _ref.length; _i < _len; y = ++_i) {
        row = _ref[y];
        chars = row.map(function(square, x) {
          var attrs, char;
          attrs = [];
          char = x === _this.bot.x && y === _this.bot.y ? (_this.bot.color === 'red' ? attrs.push(31) : void 0, _this.bot.color === 'green' ? attrs.push(32) : void 0, ['^', '>', 'v', '<'][_this.bot.dir]) : square.elev;
          if (square.color === 'red') {
            attrs.push(41);
          }
          if (square.color === 'green') {
            attrs.push(42);
          }
          if (square.goal) {
            attrs.push(1);
          }
          if (square.tagged) {
            attrs.push(4);
          }
          if (square.lift) {
            attrs.push(7);
          }
          if (attrs.length) {
            char = "[" + (attrs.join(';')) + "m" + char + "[0m";
          }
          return char;
        });
        _results.push(console.log(chars.join('')));
      }
      return _results;
    };

    LightbotGame.prototype.execute = function(instr) {
      var diff, next, square, x, y, _ref, _ref1, _ref2;
      if (!(instr.color && (instr.color !== this.bot.color))) {
        square = this.board[this.bot.y][this.bot.x];
        switch (instr.action) {
          case 'p1':
          case 'p2':
            this.prog.callProc(instr.action);
            return;
          case 'forward':
          case 'jump':
            _ref = (function() {
              switch (this.bot.dir) {
                case 0:
                  return [this.bot.y - 1, this.bot.x];
                case 1:
                  return [this.bot.y, this.bot.x + 1];
                case 2:
                  return [this.bot.y + 1, this.bot.x];
                case 3:
                  return [this.bot.y, this.bot.x - 1];
              }
            }).call(this), y = _ref[0], x = _ref[1];
            next = (_ref1 = this.board[y]) != null ? _ref1[x] : void 0;
            if (next) {
              if (instr.action === 'forward') {
                if (next.elev === square.elev) {
                  this.bot.moveTo(x, y);
                }
                this.emit('moveBot', x, y);
              } else {
                diff = next.elev - square.elev;
                if (diff === 1 || diff < 0) {
                  this.bot.moveTo(x, y);
                  this.emit('moveBot', x, y);
                }
              }
            }
            break;
          case 'bulb':
            square = this.board[this.bot.y][this.bot.x];
            if (square.goal) {
              square.tagged = !square.tagged;
              this.emit('toggleGoal', this.bot.x, this.bot.y, square.tagged);
            } else if (square.color) {
              this.bot.color = this.bot.color === square.color ? null : square.color;
              this.emit('botChangeColor', this.bot.color);
            } else if (square.lift) {
              square.elev = (function() {
                switch (square.elev) {
                  case 0:
                    return 2;
                  case 2:
                    return 4;
                  case 4:
                    return 0;
                  default:
                    throw "invalid lift elevation: " + square.elev;
                }
              })();
              this.emit('liftMove', this.bot.x, this.bot.y, square.elev);
            } else if (square.warp) {
              (_ref2 = this.bot).moveTo.apply(_ref2, square.warp);
              this.emit.apply(this, ['moveBot'].concat(__slice.call(square.warp)));
            }
            break;
          case 'right':
            this.bot.turnRight();
            this.emit('turnBot', this.bot.dir);
            break;
          case 'left':
            this.bot.turnLeft();
            this.emit('turnBot', this.bot.dir);
            break;
          case 'return':
            this.prog.returnFromProc();
        }
      }
      return this.prog.increment();
    };

    return LightbotGame;

  })(EventEmitter);

}).call(this);

},{"./bot":1,"./instruction":4,"./program":5,"./square":6,"events":7}],3:[function(require,module,exports){
// Generated by CoffeeScript 1.6.3
(function() {
  module.exports = {
    Game: require('./game'),
    Bot: require('./bot'),
    Program: require('./program'),
    Instruction: require('./instruction'),
    Square: require('./square')
  };

}).call(this);

},{"./bot":1,"./game":2,"./instruction":4,"./program":5,"./square":6}],4:[function(require,module,exports){
// Generated by CoffeeScript 1.6.3
(function() {
  var LightbotInstruction, actions, colors,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  actions = ['forward', 'right', 'left', 'jump', 'bulb', 'p1', 'p2', 'return'];

  colors = ['green', 'red'];

  module.exports = LightbotInstruction = (function() {
    function LightbotInstruction(action, color) {
      var _ref, _ref1;
      this.action = action;
      this.color = color != null ? color : null;
      if (_ref = this.action, __indexOf.call(actions, _ref) < 0) {
        throw new Error("invalid action: " + this.action);
      }
      if ((this.color != null) && (_ref1 = !this.color, __indexOf.call(colors, _ref1) >= 0)) {
        throw new Error("invalid color: " + this.color);
      }
    }

    LightbotInstruction.prototype.draw = function() {
      var line;
      line = this.action;
      if (this.color) {
        line = "[" + (this.color === 'red' ? 31 : 32) + "m" + line + "[0m";
      }
      return console.log(line);
    };

    return LightbotInstruction;

  })();

}).call(this);

},{}],5:[function(require,module,exports){
// Generated by CoffeeScript 1.6.3
(function() {
  var LightbotProgram;

  module.exports = LightbotProgram = (function() {
    function LightbotProgram(procs, cur_proc, pc) {
      this.procs = procs;
      this.cur_proc = cur_proc != null ? cur_proc : 'main';
      this.pc = pc != null ? pc : 0;
      this.callers = [];
    }

    LightbotProgram.prototype.state = function() {
      return "" + this.cur_proc + "[" + this.pc + "]";
    };

    LightbotProgram.prototype.next = function() {
      return this.procs[this.cur_proc][this.pc];
    };

    LightbotProgram.prototype.increment = function() {
      var _ref, _results;
      this.pc++;
      _results = [];
      while (this.callers.length && !this.next()) {
        _ref = this.callers.pop(), this.cur_proc = _ref[0], this.pc = _ref[1];
        _results.push(this.pc++);
      }
      return _results;
    };

    LightbotProgram.prototype.returnFromProc = function() {
      var _ref;
      if (this.callers.length) {
        _ref = this.callers.pop(), this.cur_proc = _ref[0], this.pc = _ref[1];
        return this.pc++;
      } else {
        return this.pc = this.procs[this.cur_proc].length - 1;
      }
    };

    LightbotProgram.prototype.callProc = function(p) {
      this.callers.push([this.cur_proc, this.pc]);
      this.cur_proc = p;
      return this.pc = 0;
    };

    return LightbotProgram;

  })();

}).call(this);

},{}],6:[function(require,module,exports){
// Generated by CoffeeScript 1.6.3
(function() {
  var LightbotSquare;

  module.exports = LightbotSquare = (function() {
    function LightbotSquare(_arg) {
      var _ref;
      _ref = _arg != null ? _arg : {}, this.color = _ref.color, this.goal = _ref.goal, this.elev = _ref.elev, this.tagged = _ref.tagged, this.lift = _ref.lift, this.warp = _ref.warp;
      if (this.elev == null) {
        this.elev = 0;
      }
    }

    return LightbotSquare;

  })();

}).call(this);

},{}],7:[function(require,module,exports){
var process=require("__browserify_process");if (!process.EventEmitter) process.EventEmitter = function () {};

var EventEmitter = exports.EventEmitter = process.EventEmitter;
var isArray = typeof Array.isArray === 'function'
    ? Array.isArray
    : function (xs) {
        return Object.prototype.toString.call(xs) === '[object Array]'
    }
;
function indexOf (xs, x) {
    if (xs.indexOf) return xs.indexOf(x);
    for (var i = 0; i < xs.length; i++) {
        if (x === xs[i]) return i;
    }
    return -1;
}

// By default EventEmitters will print a warning if more than
// 10 listeners are added to it. This is a useful default which
// helps finding memory leaks.
//
// Obviously not all Emitters should be limited to 10. This function allows
// that to be increased. Set to zero for unlimited.
var defaultMaxListeners = 10;
EventEmitter.prototype.setMaxListeners = function(n) {
  if (!this._events) this._events = {};
  this._events.maxListeners = n;
};


EventEmitter.prototype.emit = function(type) {
  // If there is no 'error' event listener then throw.
  if (type === 'error') {
    if (!this._events || !this._events.error ||
        (isArray(this._events.error) && !this._events.error.length))
    {
      if (arguments[1] instanceof Error) {
        throw arguments[1]; // Unhandled 'error' event
      } else {
        throw new Error("Uncaught, unspecified 'error' event.");
      }
      return false;
    }
  }

  if (!this._events) return false;
  var handler = this._events[type];
  if (!handler) return false;

  if (typeof handler == 'function') {
    switch (arguments.length) {
      // fast cases
      case 1:
        handler.call(this);
        break;
      case 2:
        handler.call(this, arguments[1]);
        break;
      case 3:
        handler.call(this, arguments[1], arguments[2]);
        break;
      // slower
      default:
        var args = Array.prototype.slice.call(arguments, 1);
        handler.apply(this, args);
    }
    return true;

  } else if (isArray(handler)) {
    var args = Array.prototype.slice.call(arguments, 1);

    var listeners = handler.slice();
    for (var i = 0, l = listeners.length; i < l; i++) {
      listeners[i].apply(this, args);
    }
    return true;

  } else {
    return false;
  }
};

// EventEmitter is defined in src/node_events.cc
// EventEmitter.prototype.emit() is also defined there.
EventEmitter.prototype.addListener = function(type, listener) {
  if ('function' !== typeof listener) {
    throw new Error('addListener only takes instances of Function');
  }

  if (!this._events) this._events = {};

  // To avoid recursion in the case that type == "newListeners"! Before
  // adding it to the listeners, first emit "newListeners".
  this.emit('newListener', type, listener);

  if (!this._events[type]) {
    // Optimize the case of one listener. Don't need the extra array object.
    this._events[type] = listener;
  } else if (isArray(this._events[type])) {

    // Check for listener leak
    if (!this._events[type].warned) {
      var m;
      if (this._events.maxListeners !== undefined) {
        m = this._events.maxListeners;
      } else {
        m = defaultMaxListeners;
      }

      if (m && m > 0 && this._events[type].length > m) {
        this._events[type].warned = true;
        console.error('(node) warning: possible EventEmitter memory ' +
                      'leak detected. %d listeners added. ' +
                      'Use emitter.setMaxListeners() to increase limit.',
                      this._events[type].length);
        console.trace();
      }
    }

    // If we've already got an array, just append.
    this._events[type].push(listener);
  } else {
    // Adding the second element, need to change to array.
    this._events[type] = [this._events[type], listener];
  }

  return this;
};

EventEmitter.prototype.on = EventEmitter.prototype.addListener;

EventEmitter.prototype.once = function(type, listener) {
  var self = this;
  self.on(type, function g() {
    self.removeListener(type, g);
    listener.apply(this, arguments);
  });

  return this;
};

EventEmitter.prototype.removeListener = function(type, listener) {
  if ('function' !== typeof listener) {
    throw new Error('removeListener only takes instances of Function');
  }

  // does not use listeners(), so no side effect of creating _events[type]
  if (!this._events || !this._events[type]) return this;

  var list = this._events[type];

  if (isArray(list)) {
    var i = indexOf(list, listener);
    if (i < 0) return this;
    list.splice(i, 1);
    if (list.length == 0)
      delete this._events[type];
  } else if (this._events[type] === listener) {
    delete this._events[type];
  }

  return this;
};

EventEmitter.prototype.removeAllListeners = function(type) {
  if (arguments.length === 0) {
    this._events = {};
    return this;
  }

  // does not use listeners(), so no side effect of creating _events[type]
  if (type && this._events && this._events[type]) this._events[type] = null;
  return this;
};

EventEmitter.prototype.listeners = function(type) {
  if (!this._events) this._events = {};
  if (!this._events[type]) this._events[type] = [];
  if (!isArray(this._events[type])) {
    this._events[type] = [this._events[type]];
  }
  return this._events[type];
};

EventEmitter.listenerCount = function(emitter, type) {
  var ret;
  if (!emitter._events || !emitter._events[type])
    ret = 0;
  else if (typeof emitter._events[type] === 'function')
    ret = 1;
  else
    ret = emitter._events[type].length;
  return ret;
};

},{"__browserify_process":8}],8:[function(require,module,exports){
// shim for using process in browser

var process = module.exports = {};

process.nextTick = (function () {
    var canSetImmediate = typeof window !== 'undefined'
    && window.setImmediate;
    var canPost = typeof window !== 'undefined'
    && window.postMessage && window.addEventListener
    ;

    if (canSetImmediate) {
        return function (f) { return window.setImmediate(f) };
    }

    if (canPost) {
        var queue = [];
        window.addEventListener('message', function (ev) {
            if (ev.source === window && ev.data === 'process-tick') {
                ev.stopPropagation();
                if (queue.length > 0) {
                    var fn = queue.shift();
                    fn();
                }
            }
        }, true);

        return function nextTick(fn) {
            queue.push(fn);
            window.postMessage('process-tick', '*');
        };
    }

    return function nextTick(fn) {
        setTimeout(fn, 0);
    };
})();

process.title = 'browser';
process.browser = true;
process.env = {};
process.argv = [];

process.binding = function (name) {
    throw new Error('process.binding is not supported');
}

// TODO(shtylman)
process.cwd = function () { return '/' };
process.chdir = function (dir) {
    throw new Error('process.chdir is not supported');
};

},{}]},{},[3])
(3)
});
;