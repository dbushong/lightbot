// Generated by CoffeeScript 1.6.3
(function() {
  var LightbotSquare, _;

  _ = require('underscore');

  module.exports = LightbotSquare = (function() {
    function LightbotSquare(_arg) {
      var _ref;
      _ref = _arg != null ? _arg : {}, this.color = _ref.color, this.goal = _ref.goal, this.elev = _ref.elev, this.tagged = _ref.tagged;
      if (this.elev == null) {
        this.elev = 0;
      }
      if (this.goal == null) {
        this.goal = true;
      }
      if (this.tagged == null) {
        this.tagged = false;
      }
      if (this.color) {
        this.goal = false;
      }
      if (this.goal) {
        this.color = null;
      }
      if (!this.goal) {
        this.tagged = false;
      }
    }

    return LightbotSquare;

  })();

}).call(this);