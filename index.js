// Generated by CoffeeScript 2.5.1
(function() {
  var GridWidth, SquareWidth, _, background, canvas, clear, ctx, drawAll, drawPiece, game, grids, i, initGrid, j, loadOthello, offset, player, r, rc, update;

  SquareWidth = Math.min(window.innerWidth, window.innerHeight) * .8;

  GridWidth = SquareWidth / 8;

  canvas = document.getElementById("canvas");

  canvas.width = canvas.height = SquareWidth * 1.1;

  offset = (canvas.width - SquareWidth) * .5;

  ctx = canvas.getContext("2d");

  rc = rough.canvas(canvas);

  background = rc.generator.rectangle(offset, 0, GridWidth * 8, GridWidth * 8, {
    fill: "rgba(10, 150, 10, 0.4)",
    fillWeight: 2,
    fillStyle: "cross-hatch"
  });

  grids = [];

  for (r = i = 0; i <= 7; r = ++i) {
    grids.push([]);
    for (_ = j = 0; j <= 7; _ = ++j) {
      grids[r].push(null);
    }
  }

  game = newGame();

  player = 1;

  clear = function() {
    return ctx.clearRect(0, 0, canvas.width, canvas.height);
  };

  initGrid = function(row, column) {
    var gr, startX, startY;
    startX = offset + row * GridWidth;
    startY = column * GridWidth;
    gr = grids[row][column];
    if (!gr) {
      grids[row][column] = rc.rectangle(startX, startY, GridWidth, GridWidth);
    } else {
      rc.draw(gr);
    }
    return drawPiece(row, column);
  };

  drawPiece = function(row, column) {
    var piece, startX, startY;
    startX = offset + row * GridWidth;
    startY = column * GridWidth;
    piece = game.board.squares[column][row];
    switch (piece._pieceType) {
      case "BLANK":
        return null;
      case "WHITE":
        return rc.circle(startX + GridWidth * .5, startY + GridWidth * .5, GridWidth * .85, {
          fill: "white",
          fillStyle: "solid"
        });
      case "BLACK":
        return rc.circle(startX + GridWidth * .5, startY + GridWidth * .5, GridWidth * .85, {
          fill: "black",
          fillStyle: "solid"
        });
      default:
        return null;
    }
  };

  drawAll = function() {
    var col, k, results, row;
    update();
    results = [];
    for (row = k = 0; k <= 7; row = ++k) {
      results.push((function() {
        var l, results1;
        results1 = [];
        for (col = l = 0; l <= 7; col = ++l) {
          results1.push(drawPiece(row, col));
        }
        return results1;
      })());
    }
    return results;
  };

  update = function() {
    var c, k, len, ref, results, row;
    clear();
    rc.draw(background);
    ref = game.board.squares;
    results = [];
    for (r = k = 0, len = ref.length; k < len; r = ++k) {
      row = ref[r];
      results.push((function() {
        var l, len1, results1;
        results1 = [];
        for (c = l = 0, len1 = row.length; l < len1; c = ++l) {
          _ = row[c];
          results1.push(initGrid(r, c));
        }
        return results1;
      })());
    }
    return results;
  };

  loadOthello = function() {
    return update();
  };

  $(function() {
    return loadOthello();
  });

  canvas.addEventListener('click', function(event) {
    var col, row, x, y;
    [x, y] = getMousePosition(canvas, event);
    row = Math.floor((x - offset) / GridWidth);
    col = Math.floor(y / GridWidth);
    if (row < 0 || row > 7 || col < 0 || col > 7 || game.board.squares[col][row]._pieceType !== "BLANK") {
      return;
    }
    if (!game.board.isPlaceableSquare(col, row, [reversi.PIECE_TYPES.WHITE, reversi.PIECE_TYPES.BLACK][player])) {
      return;
    }
    place(game, col, row);
    drawAll();
    player++;
    player %= 2;
    return document.getElementById("turn").innerHTML = `${["White", "Black"][player]}'s turn`;
  });

}).call(this);
