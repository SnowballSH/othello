// Generated by CoffeeScript 2.5.1
(function() {
  var getMousePosition;

  getMousePosition = function(canvas, event) {
    var rect, x, y;
    rect = canvas.getBoundingClientRect();
    x = event.clientX - rect.left;
    y = event.clientY - rect.top;
    return [x, y];
  };

  window.getMousePosition = getMousePosition;

}).call(this);
