const restart = new Audio('./sound/restart.wav');
const spin = new Audio('./sound/spintetrissound.wav');
const finish = new Audio('./sound/finish.wav');
const endgame = new Audio('./sound/endgame.wav');
const dropsound = new Audio('./sound/dropsound.wav');
const winsound = new Audio('./sound/winsound.wav');
const movingsound = new Audio('./sound/movingsound.wav');

(function addSound() {
  const addTune = document.querySelector('audio');
  const playSound = document.querySelector('.play-sound');
  playSound.addEventListener('click', function() {
    if (playSound.dataset.playing === 'false') {
      playSound.dataset.playing = 'true';
      addTune.play();
    } else {
      addTune.pause();
      playSound.dataset.playing = 'false';
    }
  })
})();
