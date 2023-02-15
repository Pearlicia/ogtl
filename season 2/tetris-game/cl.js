class Tetromino {
    constructor(shape, color, x, y) {
      this.shape = shape;
      this.color = color;
      this.x = x;
      this.y = y;
    }
  
    moveLeft() {
      this.x--;
    }
  
    moveRight() {
      this.x++;
    }
  
    moveDown() {
      this.y++;
    }
  
    rotateClockwise() {
      const N = this.shape.length;
      const newShape = new Array(N).fill().map(() => new Array(N));
      for (let i = 0; i < N; i++) {
        for (let j = 0; j < N; j++) {
          newShape[i][j] = this.shape[N - 1 - j][i];
        }
      }
      this.shape = newShape;
    }
  
    rotateCounterclockwise() {
      const N = this.shape.length;
      const newShape = new Array(N).fill().map(() => new Array(N));
      for (let i = 0; i < N; i++) {
        for (let j = 0; j < N; j++) {
          newShape[i][j] = this.shape[j][N - 1 - i];
        }
      }
      this.shape = newShape;
    }
  }
  