SquareWidth = Math.min(window.innerWidth, window.innerHeight) * .8

GridWidth = SquareWidth / 8

canvas = document.getElementById "canvas"

canvas.width = canvas.height = SquareWidth * 1.1

offset = (canvas.width - SquareWidth) * .5

ctx = canvas.getContext "2d"

rc = rough.canvas canvas

original = [
  [-1, -1, -1, -1, -1, -1, -1, -1],
  [-1, -1, -1, -1, -1, -1, -1, -1],
  [-1, -1, -1, -1, -1, -1, -1, -1],
  [-1, -1, -1, 0, 1, -1, -1, -1],
  [-1, -1, -1, 1, 0, -1, -1, -1],
  [-1, -1, -1, -1, -1, -1, -1, -1],
  [-1, -1, -1, -1, -1, -1, -1, -1],
  [-1, -1, -1, -1, -1, -1, -1, -1],
]

globalData = original

player = 1

clear = ->
  ctx.clearRect 0, 0, canvas.width, canvas.height

initGrid = (row, column) ->
  startX = offset + row * GridWidth
  startY = column * GridWidth

  rc.rectangle(
    startX,
    startY,
    GridWidth,
    GridWidth,
    fill: "rgba(10, 150, 10, 0.4)",
    fillWeight: 3
  )

  drawPiece(row, column)

drawPiece = (row, column) ->
  startX = offset + row * GridWidth
  startY = column * GridWidth

  piece = globalData[row][column]
  switch piece
    when -1
      null
    when 0
      rc.circle(
        startX + GridWidth * .5,
        startY + GridWidth * .5,
        GridWidth * .85,
        fill: "white",
        fillStyle: "solid"
      )
    when 1
      rc.circle(
        startX + GridWidth * .5,
        startY + GridWidth * .5,
        GridWidth * .85,
        fill: "black",
        fillStyle: "solid"
      )
    else
      null

update = ->
  clear()
  for row, r in globalData
    for _, c in row
      initGrid(r, c)

loadOthello = ->
  globalData = localStorage.getItem "save"
  if globalData == null
    globalData = original

  update()

$ ->
  loadOthello()

canvas.addEventListener 'click', (event) ->
  [x, y] = getMousePosition(canvas, event)
  row = Math.floor((x - offset) / GridWidth)
  col = Math.floor(y / GridWidth)
  if row < 0 || row > 7 || col < 0 || col > 7 || globalData[row][col] != -1
    return
  globalData[row][col] = player
  drawPiece(row, col)

  player++
  player %= 2

  document.getElementById("turn").innerHTML = "#{["White", "Black"][player]}'s turn"
