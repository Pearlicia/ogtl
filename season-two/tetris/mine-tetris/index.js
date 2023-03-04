const canvas = document.getElementById('tetris');
const contxt = canvas.getContext('2d');

const canvasNext = document.getElementById('tetriminos');
const ctxNext = canvasNext.getContext('2d');

const canvasHold = document.getElementById('freeze');
const ctxHold = canvasHold.getContext('2d');


const addTune = document.querySelector('audio');
const playSound = document.querySelector('.play-sound');

const columns = 10;
const rows = 20;
const blockSize = 30;
const linesLevel = 10;
const colors = [
  'none',
  'cyan',
  'blue',
  'orange',
  'yellow',
  'green',
  'purple',
  'red'
];
Object.freeze(colors);

const keys = {
  ESC: 27,
  SPACE: 32,
  LEFT: 37,
  UP: 38,
  RIGHT: 39,
  DOWN: 40,
  P: 80,
  Q: 81,
  C: 67
}
const shapes = [
  [],
  [[0, 0, 0, 0], [1, 1, 1, 1], [0, 0, 0, 0], [0, 0, 0, 0]],
  [[2, 0, 0], [2, 2, 2], [0, 0, 0]],
  [[0, 0, 3], [3, 3, 3], [0, 0, 0]],
  [[4, 4], [4, 4]],
  [[0, 5, 5], [5, 5, 0], [0, 0, 0]],
  [[0, 6, 0], [6, 6, 6], [0, 0, 0]],
  [[7, 7, 0], [0, 7, 7], [0, 0, 0]]
];

Object.freeze(shapes);
Object.freeze(keys);

const points = {
  SINGLE: 100,
  DOUBLE: 300,
  TRIPLE: 500,
  TETRIS: 800,
  SOFT_DROP: 1,
  HARD_DROP: 2,
}

const level = {
  0: 800,
  1: 720,
  2: 630,
  3: 550,
  4: 470,
  5: 380,
  6: 300,
  7: 220,
  8: 130,
  9: 100,
  10: 80,
  11: 80,
  12: 80,
  13: 70,
  14: 70,
  15: 70,
  16: 50,
  17: 50,
  18: 50,
  19: 30,
  20: 30,
}
Object.freeze(points);
Object.freeze(level);

const rotation = {
  LEFT: 'left',
  RIGHT: 'right'
}
Object.freeze(rotation);

let playerStatus = {
  score: 0,
  level: 0,
  lines: 0
};

function newGame(key, value) {
  let e = document.getElementById(key);
  if (e) {
    e.textContent = value;
  }
}

let player = new Proxy(playerStatus, {
  set: (target, key, value) => {
    target[key] = value;
    newGame(key, value);
    return true;
  }
});

moves = {
  [keys.LEFT]:   (k) => ({ ...k, x: k.x - 1 }),
  [keys.RIGHT]:  (k) => ({ ...k, x: k.x + 1 }),
  [keys.DOWN]:   (k) => ({ ...k, y: k.y + 1 }),
  [keys.SPACE]:  (k) => ({ ...k, y: k.y + 1 }),
  [keys.UP]:     (k) => place.rotate(k, rotation.RIGHT),
  [keys.Q]:      (k) => place.rotate(k, rotation.LEFT),
};

let place = new Place(contxt, ctxNext, ctxHold);

controlTetris(ctxNext);
controlTetris(ctxHold);

function controlTetris(contxt) {
  contxt.canvas.width = 4 * blockSize;
  contxt.canvas.height = 4 * blockSize;
  contxt.scale(blockSize, blockSize);
}

function startGame() {
  document.removeEventListener('keydown', keyboard);
  document.addEventListener('keydown', keyboard);
}

function keyboard(e) {
  if (e.keyCode === keys.P) {
    addTune.halt();
    halt();
  }
  if (e.keyCode === keys.ESC) {
    addTune.halt();
    addTune.currrentTime = 0;
    end.game();
    endGame();
  } else if (moves[e.keyCode]) {
    e.preventDefault();
    let k = moves[e.keyCode](place.piece);
    if (e.keyCode === keys.SPACE) {
      while (place.valid(k)) {
        player.score += points.HARD_DROP;
        place.piece.move(k);
        k = moves[keys.DOWN](place.piece);
      }
      place.piece.hardDrop();
    } else if (place.valid(k)) {
      place.piece.move(k);
      if (e.keyCode === keys.DOWN) {
        player.score += points.SOFT_DROP;
      }
    } else
      fall.game();
  }
}

function resetGame() {
  player.score = 0;
  player.lines = 0;
  player.level = 0;
  place.reset();
  duration = { start: performance.now(), elapsed: 0, level: level[player.level] };
}

let result = null;
let duration = null;

function game() {
  contxt.paused = false;
  startGame();

  playSound.dataset.playing = 'true';
  addTune.game();
  resetGame();

  if (result) {
    haltMovingTetris(result);
  }
  moveTetris();
}

function moveTetris(present = 0) {
  duration.elapsed = present - duration.start;
  if (duration.elapsed > duration.level) {
    duration.start = present;
    if (!place.drop()) {
      addTune.halt();
      addTune.currentTime = 0;
      endGame();
      return;
    }
  }

  contxt.clearRect(0, 0, contxt.canvas.width, contxt.canvas.height);

  place.draw();
  result = movingTetris(moveTetris);
}

function endGame() {
  haltMovingTetris(result);
  result = null;
  contxt.fillStyle = 'white';
  contxt.fillRect(1, 3, 8, 1.2);
  contxt.font = '1px Futura';
  contxt.fillStyle = 'red';
  contxt.fillText('GAME OVER', 1.8, 4);
}

function halt() {
  if (!result) {
    contxt.paused = true;
    commence();
  }

  haltMovingTetris(result);
  result = null;

  contxt.fillStyle = 'White';
  contxt.fillRect(1, 3, 7, 1.2);
  contxt.font = '1px Futura';
  contxt.fillStyle = 'blue';
  contxt.fillText('  PAUSE', 3, 4);
  contxt.paused = true;
}

function commence(e) {
  if (result) {
    addTune.halt();
    halt();
  } else {
    let isPaused = contxt.paused;
    if (!isPaused) {
      contxt.clearRect(0, 0, contxt.canvas.width, contxt.canvas.height);
      addTune.currentTime = 0;
    }
    let timer = 3;
    document.getElementById('counts').innerHTML = timer;
    let countTime = setInterval(commence, 1000);
    function commence() {
      timer -= 1;
      document.getElementById('counts').innerHTML = timer;
      if (timer <= 0) {
        clearInterval(countTime);
        if (!isPaused) {
          game();
        } else {
          contxt.paused = false;
          document.getElementById("counts").innerHTML = '';
          addTune.game();
          moveTetris();
          return;
        }
        document.getElementById("counts").innerHTML = '';
        return;
      }
    }
  }
}

