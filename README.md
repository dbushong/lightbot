lightbot
========

Summary
-------

An unauthorized simulator for [Light-bot](https://play.google.com/store/apps/details?id=com.lightbot.lightbot).

Usage
-----

For library usage, see `Lightbot.Game.load()` in `src/game.coffee`

For command-line usage, put your board, starting bot position, and 
program into a JSON file modeled after the examples in
`examples/level-*.json` then run `./bin/play file.json`

For browser usage, see the example in `public/index.html` that uses the 
browserify-generated `public/lightbot.js`
