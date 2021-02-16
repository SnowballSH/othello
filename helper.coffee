getMousePosition = (canvas, event) ->
  rect = canvas.getBoundingClientRect()
  x = event.clientX - rect.left
  y = event.clientY - rect.top
  console.log("Coordinate x: " + x, "Coordinate y: " + y)
