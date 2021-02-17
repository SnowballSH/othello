reversi = require 'reversi'

newGame = ->
  game = new reversi.Game()
  game

place = (game, row, col) ->
  game.proceed(row, col)
  console.log(game.toText())
  game

window.newGame = newGame
window.place = place

window.reversi = reversi
