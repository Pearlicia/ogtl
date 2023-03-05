class GameArea {
  constructor(contxt, followinTet, haltTet) {
    this.contxt = contxt;
    this.followinTet = followinTet;
    this.haltTet = haltTet;
    this.setUp();
  }

  setUp() {
    this.contxt.canvas.width = columns * block;
    this.contxt.canvas.height = rows * block;
    this.contxt.scale(block, block);
  }

  deleteHalt() {
    const { width, height } = this.haltTet.canvas;
    this.haltTet.clearRect(0, 0, width, height);
    this.haltTet.piece = false;
  }

  startOver() {
    this.grid = this.newGrid();
    this.deleteHalt();
    this.fragment = new Fragment(this.contxt);
    this.fragment.genesis();
    this.newPlay();
  }

  newPlay() {
    const { width, height } = this.followinTet.canvas;
    this.followin = new Piece(this.followinContxt);
    this.followinTet.clearRect(0, 0, width, height);
    this.followin.write();
  }

  write() {
    this.fragment.sketch();
    this.scoreTable();
  }

  sink() {
    let k = steps[keys.DOWN](this.fragment);
    if (this.approved(p)) {
      this.fragment.advance(p);
    } else {
      this.constant();
      this.setline();
      if (this.fragment.y === 0) {
        gameover.game();
        return false;
      }
      fall.game();
      this.fragment = this.next;
      this.fragment.contxt = this.contxt;
      this.fragment.genesis();
      this.newPlay();
    }
    return true;
  }

  setline() {
    let lines = 0;

    this.grid.forEach((row, y) => {
      if (row.every((value) => value > 0)) {
        lines++;

        this.grid.splice(y, 1);
        clear.game();
        this.grid.unshift(Array(columns).fill(0));
      }
    });

    if (lines > 0) {
      player.score += this.getline(lines);
      player.lines += lines;

      if (player.lines >= linesLevel) {
        player.level++;
        player.lines -= linesLevel;
        time.level = level[player.level];
      }
    }
  }

  approved(k) {
    return k.shape.every((row, sy) => {
      return row.every((value, sx) => {
        let x = k.x + sx;
        let y = k.y + sy;
        return (
          value === 0 || (this.interior(x, y) && this.vacant(x, y))
        );
      });
    });
  }

  constant() {
    this.fragment.shape.forEach((row, y) => {
      row.forEach((value, x) => {
        if (value > 0) {
          this.grid[y + this.fragment.y][x + this.fragment.x] = value;
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

  interior(x, y) {
    return x >= 0 && x < columns && y <= rows;
  }

  vacant(x, y) {
    return this.grid[y] && this.grid[y][x] === 0;
  }

  spintetris(fragment, move) {
    let k = JSON.parse(JSON.stringify(fragment));
    if (!fragment.hardDropped) {
      for (let y = 0; y < k.shape.length; y++)
        for (let x = 0; x < y; x++)
          [k.shape[x][y], k.shape[y][x]] = [k.shape[y][x], k.shape[x][y]];
      if (move === rotation.RIGHT) {
        k.shape.forEach((row) => row.reverse());
        rotate.play();
      } else if (move === rotation.LEFT) {
        k.shape.reverse();
        rotate.play();
      }
    }
    return k;
  }

  flipfragment() {
    if (!this.haltTet.fragment) {
      this.haltTet.fragment = this.fragment;
      this.fragment = this.next;
      this.newPlay();
    } else {
      let temp = this.fragment;
      this.fragment = this.haltTet.fragment;
      this.haltTet.fragment = temp;
    }
    this.haltTet.fragment.contxt = this.haltTet;
    this.fragment.contxt = this.contxt;
    this.fragment.genesis();
    this.halt = this.haltTet.fragment;
    const { width, height } = this.haltTet.canvas;
    this.haltTet.clearRect(0, 0, width, height);
    this.haltTet.fragment.x = 0;
    this.haltTet.fragment.y = 0;
    this.haltTet.fragment.draw();
  }

  halt() {
    if (this.fragment.swapped) return;
    this.flipfragment();
    this.fragment.swapped = true;
    return this.fragment;
  }

  getline(lines, level) {
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
