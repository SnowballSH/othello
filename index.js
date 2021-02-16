// Generated by CoffeeScript 2.5.1
(function() {
  var GridWidth, SquareWidth, canvas, clear, ctx, draw, loadOthello, offset, original, player, rc, update;

  SquareWidth = Math.min(window.innerWidth, window.innerHeight) * .8;

  GridWidth = SquareWidth / 8;

  canvas = document.getElementById("canvas");

  canvas.width = canvas.height = SquareWidth * 1.1;

  offset = (canvas.width - SquareWidth) * .5;

  ctx = canvas.getContext("2d");

  rc = rough.canvas(canvas);

  original = [[-1, -1, -1, -1, -1, -1, -1, -1], [-1, -1, -1, -1, -1, -1, -1, -1], [-1, -1, -1, -1, -1, -1, -1, -1], [-1, -1, -1, 0, 1, -1, -1, -1], [-1, -1, -1, 1, 0, -1, -1, -1], [-1, -1, -1, -1, -1, -1, -1, -1], [-1, -1, -1, -1, -1, -1, -1, -1], [-1, -1, -1, -1, -1, -1, -1, -1]];

  player = 1;

  clear = function() {
    return ctx.clearRect(0, 0, canvas.width, canvas.height);
  };

  draw = function(data, row, column) {
    var piece, startX, startY;
    startX = offset + row * GridWidth;
    startY = column * GridWidth;
    rc.rectangle(startX, startY, GridWidth, GridWidth, {
      fill: "rgba(10, 150, 10, 0.4)",
      fillWeight: 3
    });
    piece = data[row][column];
    switch (piece) {
      case -1:
        return null;
      case 0:
        return rc.circle(startX + GridWidth * .5, startY + GridWidth * .5, GridWidth * .85, {
          fill: "white",
          fillStyle: "solid"
        });
      case 1:
        return rc.circle(startX + GridWidth * .5, startY + GridWidth * .5, GridWidth * .85, {
          fill: "black",
          fillStyle: "solid"
        });
      default:
        return null;
    }
  };

  update = function(data) {
    var _, c, i, len, r, results, row;
    results = [];
    for (r = i = 0, len = data.length; i < len; r = ++i) {
      row = data[r];
      results.push((function() {
        var j, len1, results1;
        results1 = [];
        for (c = j = 0, len1 = row.length; j < len1; c = ++j) {
          _ = row[c];
          results1.push(draw(data, r, c));
        }
        return results1;
      })());
    }
    return results;
  };

  loadOthello = function() {
    var data;
    data = localStorage.getItem("save");
    if (data === null) {
      data = original;
    }
    return update(data);
  };

  $(function() {
    return loadOthello();
  });

  canvas.addEventListener('click', function(event) {
    return getMousePosition(canvas, event);
  });

}).call(this);