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

player = 1

clear = ->
  ctx.clearRect 0, 0, canvas.width, canvas.height

draw = (data, row, column) ->
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

  piece = data[row][column]
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

update = (data) ->
  for row, r in data
    for _, c in row
      draw(data, r, c)

loadOthello = ->
  data = localStorage.getItem "save"
  if data == null
    data = original

  update(data)

$ ->
  loadOthello()

canvas.addEventListener 'click', (event) ->
  getMousePosition(canvas, event)
