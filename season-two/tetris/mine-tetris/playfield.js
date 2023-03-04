class GameArea {
  constructor(contxt, followinTet, haltTet) {
    this.contxt = contxt;
    this.followinTet = followinTet;
    this.haltTet = haltTet;
    this.setUp();
  }

  setUp() {
    this.contxt.canvas.width = columns * blockSize;
    this.contxt.canvas.height = rows * blockSize;
    this.contxt.scale(blockSize, blockSize);
  }

  deleteHalt() {
    const { width, height } = this.haltTet.canvas;
    this.haltTet.clearRect(0, 0, width, height);
    this.haltTet.piece = false;
  }

  startOver() {
    this.grid = this.newGrid();
    this.deleteHalt();
    this.piece = new Piece(this.contxt);
    this.piece.beginGame();
    this.newPlay();
  }

  newPlay() {
    const { width, height } = this.followinTet.canvas;
    this.followin = new Piece(this.followinContxt);
    this.followinTet.clearRect(0, 0, width, height);
    this.followin.drawPlay();
  }

  drawPlay() {
    this.piece.draw();
    this.scoreTable();
  }

  drop() {
    let p = moves[keys.DOWN](this.piece);
    if (this.valid(p)) {
      this.piece.move(p);
    } else {
      this.constant();
      this.clearLines();
      if (this.piece.y === 0) {
        gameover.play();
        return false;
      }
      fall.play();
      this.piece = this.next;
      this.piece.ctx = this.ctx;
      this.piece.beginGame();
      this.getNewPiece();
    }
    return true;
  }

  clearLines() {
    let lines = 0;

    this.grid.forEach((row, y) => {
      if (row.every((value) => value > 0)) {
        lines++;

        this.grid.splice(y, 1);
        clear.play();
        // Add zero filled row at the top.
        this.grid.unshift(Array(columns).fill(0));
      }
    });

    if (lines > 0) {
      player.score += this.getLinesClearedPoints(lines);
      player.lines += lines;

      if (player.lines >= linesLevel) {
        player.level++;
        player.lines -= linesLevel;
        time.level = level[player.level];
      }
    }
  }

  valid(p) {
    return p.shape.every((row, dy) => {
      return row.every((value, dx) => {
        let x = p.x + dx;
        let y = p.y + dy;
        return (
          value === 0 || (this.isInsideWalls(x, y) && this.notOccupied(x, y))
        );
      });
    });
  }

  constant() {
    this.piece.shape.forEach((row, y) => {
      row.forEach((value, x) => {
        if (value > 0) {
          this.grid[y + this.piece.y][x + this.piece.x] = value;
        }
      });
    });
  }

  scoreTable() {
    this.grid.forEach((row, y) => {
      row.forEach((value, x) => {
        if (value > 0) {
          this.contxt.fillStyle = colors[value];
          this.contxt.fillRect(x, y, 1, 1);
        }
      });
    });
  }

  newGrid() {
    return Array.from({ length: rows }, () => Array(columns).fill(0));
  }

  isInsideWalls(x, y) {
    return x >= 0 && x < columns && y <= rows;
  }

  notOccupied(x, y) {
    return this.grid[y] && this.grid[y][x] === 0;
  }

  spintetris(piece, direction) {
    let p = JSON.parse(JSON.stringify(piece));
    if (!piece.hardDropped) {
      for (let y = 0; y < p.shape.length; y++)
        for (let x = 0; x < y; x++)
          [p.shape[x][y], p.shape[y][x]] = [p.shape[y][x], p.shape[x][y]];
      if (direction === rotation.RIGHT) {
        p.shape.forEach((row) => row.reverse());
        rotate.play();
      } else if (direction === rotation.LEFT) {
        p.shape.reverse();
        rotate.play();
      }
    }
    return p;
  }

  swapPieces() {
    if (!this.ctxHold.piece) {
      this.ctxHold.piece = this.piece;
      this.piece = this.next;
      this.getNewPiece();
    } else {
      let temp = this.piece;
      this.piece = this.ctxHold.piece;
      this.ctxHold.piece = temp;
    }
    this.ctxHold.piece.ctx = this.ctxHold;
    this.piece.ctx = this.ctx;
    this.piece.beginGame();
    this.hold = this.ctxHold.piece;
    const { width, height } = this.ctxHold.canvas;
    this.ctxHold.clearRect(0, 0, width, height);
    this.ctxHold.piece.x = 0;
    this.ctxHold.piece.y = 0;
    this.ctxHold.piece.draw();
  }

  hold() {
    if (this.piece.swapped) return;
    this.swapPieces();
    this.piece.swapped = true;
    return this.piece;
  }

  getLinesClearedPoints(lines, level) {
    const lineClearPoints =
      lines === 1
        ? points.SINGLE
        : lines === 2
        ? points.DOUBLE
        : lines === 3
        ? points.TRIPLE
        : lines === 4
        ? points.TETRIS
        : 0;

    return (player.level + 1) * lineClearPoints;
  }
}
