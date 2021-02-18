SquareWidth = Math.min(window.innerWidth, window.innerHeight) * .8 - 60

GridWidth = SquareWidth / 8

canvas = document.getElementById "canvas"

canvas.width = canvas.height = SquareWidth * 1.1

offset = (canvas.width - SquareWidth) * .5

ctx = canvas.getContext "2d"

rc = rough.canvas canvas

background = rc.generator.rectangle(
  offset,
  0,
  GridWidth * 8,
  GridWidth * 8,
  fill: "rgba(10, 150, 10, 0.4)",
  fillWeight: 2
  fillStyle: "cross-hatch"
)

grids = []
for r in [0..7]
  grids.push([])
  for _ in [0..7]
    grids[r].push(null)

game = newGame()

player = 1

clear = ->
  ctx.clearRect 0, 0, canvas.width, canvas.height

initGrid = (row, column) ->
  startX = offset + row * GridWidth
  startY = column * GridWidth

  gr = grids[row][column]

  if !gr
    grids[row][column] = rc.rectangle(
      startX,
      startY,
      GridWidth,
      GridWidth,
    )
  else
    rc.draw(gr)

  drawPiece(row, column)

drawPiece = (row, column) ->
  startX = offset + row * GridWidth
  startY = column * GridWidth

  piece = game.board.squares[column][row]
  switch piece._pieceType
    when "BLANK"
      null
    when "WHITE"
      rc.circle(
        startX + GridWidth * .5,
        startY + GridWidth * .5,
        GridWidth * .85,
        fill: "white",
        fillStyle: "solid"
      )
    when "BLACK"
      rc.circle(
        startX + GridWidth * .5,
        startY + GridWidth * .5,
        GridWidth * .85,
        fill: "black",
        fillStyle: "solid"
      )
    else
      null

drawAll = ->
  update()
  for row in [0..7]
    for col in [0..7]
      drawPiece(row, col)

update = ->
  clear()
  rc.draw(background)
  for row, r in game.board.squares
    for _, c in row
      initGrid(r, c)

loadOthello = ->
  update()

$ ->
  loadOthello()

canvas.addEventListener 'click', (event) ->
  [x, y] = getMousePosition(canvas, event)
  row = Math.floor((x - offset) / GridWidth)
  col = Math.floor(y / GridWidth)

  if row < 0 || row > 7 || col < 0 || col > 7 || game.board.squares[col][row]._pieceType != "BLANK"
    return

  if !game.board.isPlaceableSquare(col, row, [reversi.PIECE_TYPES.WHITE, reversi.PIECE_TYPES.BLACK][player])
    return

  place(game, col, row)

  drawAll()

  upd = ->
    player++
    player %= 2

    document.getElementById("turn").innerHTML = "#{["White", "Black"][player]}'s turn"

    p = game.board.countByPieceType()
    document.getElementById("count").innerHTML = "⚫: #{p[reversi.PIECE_TYPES.BLACK]} | ⚪: #{p[reversi.PIECE_TYPES.WHITE]}"

  upd()

  if !game.board.hasPlacableSquare([reversi.PIECE_TYPES.WHITE, reversi.PIECE_TYPES.BLACK][player])
    upd()

  if game.isEnded
    document.getElementById("count").innerHTML += " (Game Ended!)"
