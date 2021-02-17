getMousePosition = (canvas, event) ->
  rect = canvas.getBoundingClientRect()
  x = event.clientX - rect.left
  y = event.clientY - rect.top
  [x, y]
