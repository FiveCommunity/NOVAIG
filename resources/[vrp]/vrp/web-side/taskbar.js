let canvas = document.querySelector("canvas");
let ctx = canvas.getContext("2d");

let W = canvas.width;
let H = canvas.height;
let degrees = 0;
let new_degrees = 0;
let time = 0;
let color = "#ff0000";
let txtcolor = "#ffffff";
let bgcolor = "#FFFFFF40"; // Background
let bgcolor2 = "#ffffff"; //
let bgcolor3 = "#00ff00";
let key_to_press;
let attempt = 1;
let g_start, g_end;
let animation_loop;
let game_started = false;

let streak = 0;
let max_streak = 3;

let gradientCanvas = document.createElement("canvas");
let gradientCtx = gradientCanvas.getContext("2d");
gradientCanvas.width = W;
gradientCanvas.height = H;

let filledImage = new Image();
filledImage.src = "./progress.png";

function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min + 1) + min); //The maximum is inclusive and the minimum is inclusive
}

function whatever() {
  if (game_started === false) {
    game_started = true;
  }
}

function beforestart(streak = 0) {
  if (game_started === true) {
    canvas.style.display = "none";
  }
}

function drawProgressBar(acertos = 0) {
  // Clear the canvas every time a chart is drawn
  ctx.clearRect(0, 0, W, H);

  // Draw the gradient circle first
  ctx.drawImage(gradientCanvas, 0, 0);

  // Background 360-degree arc
  ctx.beginPath();
  ctx.strokeStyle = bgcolor;
  ctx.lineWidth = 20;
  ctx.arc(W / 2, H / 2, 100, 0, Math.PI * 2, false);
  ctx.stroke();

  // Green zone
  ctx.beginPath();
  ctx.strokeStyle = bgcolor2;
  ctx.lineWidth = 20;
  ctx.arc(
    W / 2,
    H / 2,
    100,
    g_start - 90 * Math.PI / 180,
    g_end - 90 * Math.PI / 180,
    false
  );
  ctx.stroke();

  // Angle in radians = angle in degrees * PI / 180
  let radians = degrees * Math.PI / 180;
  ctx.beginPath();
  ctx.strokeStyle = color;
  ctx.lineWidth = 40;
  ctx.arc(
    W / 2,
    H / 2,
    90,
    radians - 0.1 - 90 * Math.PI / 180,
    radians - 90 * Math.PI / 180,
    false
  );
  ctx.stroke();
  document.querySelector('.taskImageProgress .fill').style.height = `${(acertos / max_streak) * 100}%`
}

function init(correct) {
  // Clear the canvas every time a chart is drawn
  ctx.clearRect(0, 0, W, H);

  // Draw the gradient circle first
  ctx.drawImage(gradientCanvas, 0, 0);

  // Background 360-degree arc
  ctx.beginPath();
  ctx.strokeStyle = bgcolor;
  ctx.lineWidth = 20;
  ctx.arc(W / 2, H / 2, 100, 0, Math.PI * 2, false);
  ctx.stroke();

  // Green zone
  ctx.beginPath();
  ctx.strokeStyle = correct === true ? bgcolor3 : bgcolor2;
  ctx.lineWidth = 20;
  ctx.arc(
    W / 2,
    H / 2,
    100,
    g_start - 90 * Math.PI / 180,
    g_end - 90 * Math.PI / 180,
    false
  );
  ctx.stroke();

  // Angle in radians = angle in degrees * PI / 180
  let radians = degrees * Math.PI / 180;
  ctx.beginPath();
  ctx.strokeStyle = color;
  ctx.lineWidth = 40;
  ctx.arc(
    W / 2,
    H / 2,
    90,
    radians - 0.1 - 90 * Math.PI / 180,
    radians - 90 * Math.PI / 180,
    false
  );
  ctx.stroke();

  // Draw the progress bar based on streak
  drawProgressBar(streak); // Adjust as needed
  drawBackgroundCircle();

  // Display the text in the center
  // ctx.fillStyle = txtcolor;
  // ctx.font = "60px Arial";
  // ctx.textAlign = "center";
  // ctx.textBaseline = "middle";
  // ctx.fillText(streak, W / 2, H / 2);
}

function drawBackgroundCircle() {
  // Clear the gradient canvas
  gradientCtx.clearRect(0, 0, W, H);

  // Background radial gradient circle
  const gradient = gradientCtx.createRadialGradient(
    W / 2,
    H / 2,
    0,
    W / 2,
    H / 2,
    W / 4
  );

  gradient.addColorStop(0, "rgba(0, 0, 0, 0.30)");
  gradient.addColorStop(1, "rgba(0, 0, 0, 0.55)");

  gradientCtx.beginPath();
  gradientCtx.fillStyle = gradient;
  gradientCtx.arc(W / 2, H / 2, W / 3, 0, Math.PI * 2, false);
  gradientCtx.fill();
}

function draw() {
  if (typeof animation_loop !== undefined) clearInterval(animation_loop);

  g_start = getRandomInt(20, 40) / 10;
  g_end = getRandomInt(3, 5) / 5;
  g_end = g_start + g_end;

  degrees = 0;
  new_degrees = 360;

  key_to_press = "" + getRandomInt(1, 4);

  time = 12;

  animation_loop = setInterval(animate_to, time);
}

function animate_to() {
  if (degrees >= new_degrees) {
    wrong();
    fetch("https://vrp/taskEnd", {
      method: "POST",
      body: false,
    });
    canvas.style.display = "none";
    return;
  }
  degrees += 2;
  init();
}

function correct() {
  if (streak > max_streak) {
    max_streak = streak;
  }
  if (Math.random() * 10 + 1 > 5) {
    finishfirstsound();
  } else {
    finishsound2();
  }
  streak++;
}

function wrongsound() {
  var audio = document.createElement("audio");
  audio.src =
    "https://github.com/NatanDyas/natandyastest/raw/main/wrong1.ogg";
  audio.play();
}

function finishfirstsound() {
  var audio = document.createElement("audio");
  audio.src =
    "https://github.com/NatanDyas/natandyastest/raw/main/right2.ogg";
  audio.play();
}

function finishsound() {
  var audio = document.createElement("audio");
  audio.src =
    "https://github.com/NatanDyas/natandyastest/raw/main/right3.ogg";
  audio.play();
}

function finishsound2() {
  var audio = document.createElement("audio");
  audio.src = "https://github.com/NatanDyas/natandyastest/raw/main/right4.ogg";
  audio.play();
}

function wrong() {
  game_started = false;
  if (streak > max_streak) {
    max_streak = streak;
  }
  streak = 0;
  clearInterval(animation_loop);
  animation_loop = undefined;

  document.querySelector("canvas#canvas").style.display = "none";
  fetch("https://vrp/taskEnd", {
    method: "POST",
    body: false,
  });
  window.location.reload();
}

document.addEventListener("keydown", function ({ code }) {
  if (document.querySelector("canvas#canvas").style.display !== "none" && code === "KeyE" ) {
    bgcolor3 = "#ff0000";
    let d_start = (180 / Math.PI) * g_start;
    let d_end = (180 / Math.PI) * g_end;
    if (degrees < d_start) {
      wrongsound();
      wrong();
      return;
    } else if (degrees > d_end) {
      wrongsound();
      wrong();
      return;
    } else {
      bgcolor3 = "#00ff00";
      correct();
    }
    init(true);
    if (streak != 3) {
      draw();
    } else {
      finishsound();
      canvas.style.display = "none";
      document.querySelector('.taskImageProgress').style.display = 'none';
      game_started = false;
      fetch("https://vrp/taskEnd", {
        method: "POST",
        body: true,
      });
    }
  }
});

window.addEventListener("message", ({ data }) => {
  if (data.action === "createTask") {
    canvas.style.display = "";
    draw();
    document.querySelector('.taskImageProgress').style.display = 'flex'
  }
  if (data.action === "clearTasks") {
    window.location.reload();
    canvas.style.display = "none";

    clearInterval(animation_loop);
    degrees = 0;
    new_degrees = 0;
    time = 0;
    attempt = 1;
    g_start, g_end;
    animation_loop;
    game_started = false;
  }
});
