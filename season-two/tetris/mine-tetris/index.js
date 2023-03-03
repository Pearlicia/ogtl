const canvas = document.getElementById('tetris');
const contxt = canvas.getContext('2d');

const canvasNext = document.getElementById('tetriminos');
const ctxNext = canvasNext.getContext('2d');

const canvasHold = document.getElementById('freeze');
const ctxHold = canvasHold.getContext('2d');


const audioElement = document.querySelector('audio');
const playButton = document.querySelector('.play-sound');

let playerStatus = {
  score: 0,
  level: 0,
  lines: 0
};

function updatePlayer(key, value) {
  let element = document.getElementById(key);
  if (element) {
    element.textContent = value;
  }
}

let player = new Proxy(playerStatus, {
  set: (target, key, value) => {
    target[key] = value;
    updatePlayer(key, value);
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

initSidePanel(ctxNext);
initSidePanel(ctxHold);

function initSidePanel(contxt) {
  contxt.canvas.width = 4 * blockSize;
  contxt.canvas.height = 4 * blockSize;
  contxt.scale(blockSize, blockSize);
}

function startPlay() {
  document.removeEventListener('keydown', handleKeyPress);
  document.addEventListener('keydown', handleKeyPress);
}

function handleKeyPress(event) {
  if (event.keyCode === keys.P) {
    audioElement.pause();
    pause();
  }
  if (event.keyCode === keys.ESC) {
    audioElement.pause();
    audioElement.currrentTime = 0;
    end.play();
    gameOver();
  } else if (moves[event.keyCode]) {
    event.preventDefault();
    let k = moves[event.keyCode](place.piece);
    if (event.keyCode === keys.SPACE) {
      while (place.valid(k)) {
        player.score += points.HARD_DROP;
        place.piece.move(k);
        k = moves[keys.DOWN](place.piece);
      }
      place.piece.hardDrop();
    } else if (place.valid(k)) {
      place.piece.move(k);
      if (event.keyCode === keys.DOWN) {
        player.score += points.SOFT_DROP;
      }
    } else
      fall.play();
  }
}

function resetGame() {
  player.score = 0;
  player.lines = 0;
  player.level = 0;
  place.reset();
  time = { start: performance.now(), elapsed: 0, level: level[player.level] };
}

let requestId = null;
let time = null;

function play() {
  contxt.paused = false;
  startPlay();

  playButton.dataset.playing = 'true';
  audioElement.play();
  resetGame();

  if (requestId) {
    cancelAnimationFrame(requestId);
  }
  animate();
}

function animate(now = 0) {
  time.elapsed = now - time.start;
  if (time.elapsed > time.level) {
    time.start = now;
    if (!place.drop()) {
      audioElement.pause();
      audioElement.currentTime = 0;
      gameOver();
      return;
    }
  }

  contxt.clearRect(0, 0, contxt.canvas.width, contxt.canvas.height);

  place.draw();
  requestId = requestAnimationFrame(animate);
}

function gameOver() {
  cancelAnimationFrame(requestId);
  requestId = null;
  contxt.fillStyle = 'white';
  contxt.fillRect(1, 3, 8, 1.2);
  contxt.font = '1px Futura';
  contxt.fillStyle = 'red';
  contxt.fillText('GAME OVER', 1.8, 4);
}

function pause() {
  if (!requestId) {
    contxt.paused = true;
    startTime();
  }

  cancelAnimationFrame(requestId);
  requestId = null;

  contxt.fillStyle = 'White';
  contxt.fillRect(1, 3, 7, 1.2);
  contxt.font = '1px Futura';
  contxt.fillStyle = 'blue';
  contxt.fillText('  PAUSE', 3, 4);
  contxt.paused = true;
}

function startTime(e) {
  if (requestId) {
    audioElement.pause();
    pause();
  } else {
    let isPaused = contxt.paused;
    if (!isPaused) {
      contxt.clearRect(0, 0, contxt.canvas.width, contxt.canvas.height);
      audioElement.currentTime = 0;
    }
    let count = 3;
    document.getElementById('counts').innerHTML = count;
    let counter = setInterval(startTime, 1000);
    function startTime() {
      count -= 1;
      document.getElementById('counts').innerHTML = count;
      if (count <= 0) {
        clearInterval(counter);
        if (!isPaused) {
          play();
        } else {
          contxt.paused = false;
          document.getElementById("counts").innerHTML = '';
          audioElement.play();
          animate();
          return;
        }
        document.getElementById("counts").innerHTML = '';
        return;
      }
    }
  }
}

