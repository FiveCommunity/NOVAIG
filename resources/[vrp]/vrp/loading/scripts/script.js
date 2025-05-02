let numSegments = 60;
let segmentLength = 10;

let topImage;
let scaleFactor = 0.5; 

let pipa; 
let rabiola = []; 

let rotation = 0; 
let easing = 0.09; 

function preload() {
  // topImage = loadImage('./assets/cursor.svg');
}

function setup() {
  createCanvas(windowWidth, windowHeight);

  pipa = createVector(0, 0);

  for (let i = 0; i < numSegments; i++) {
    rabiola.push(createVector(0, 0));
  }

  clear();
}

function draw() {
  clear();
  // updateRabiola(mouseX, mouseY);
  // drawRabiola();
  // movePipa(mouseX, mouseY);
  // drawPipa();
}

function updateRabiola(targetX, targetY) {
  let dx = targetX - pipa.x;
  let dy = targetY - pipa.y;
  let angle = atan2(dy, dx);

  rabiola[numSegments - 1].x = pipa.x;
  rabiola[numSegments - 1].y = pipa.y + topImage.height * scaleFactor / 2;

  for (let i = numSegments - 2; i >= 0; i--) {
    let dx = rabiola[i + 1].x - rabiola[i].x;
    let dy = rabiola[i + 1].y - rabiola[i].y;
    let angle = atan2(dy, dx);
    rabiola[i].x = rabiola[i + 1].x - cos(angle) * segmentLength;
    rabiola[i].y = rabiola[i + 1].y - sin(angle) * segmentLength;
  }
}

function drawRabiola() {
  for (let i = 0; i < numSegments; i++) {
    stroke(255);
    strokeWeight(2);
    if (i % 2 === 0) {
      line(rabiola[i].x, rabiola[i].y, rabiola[i + 1].x, rabiola[i + 1].y);
    }
  }
}

function movePipa(targetX, targetY) {
  // Atualiza a posição da parte de cima da pipa
  pipa.x += (targetX - pipa.x) * easing;
  pipa.y += (targetY - pipa.y) * easing;
}

function drawPipa() {
  let targetRotation = atan2(pipa.y - mouseY, pipa.x - mouseX);

  let deltaRotation = targetRotation - rotation;
  rotation += deltaRotation * easing;

  let scaledWidth = topImage.width * scaleFactor;
  let scaledHeight = topImage.height * scaleFactor;

  push();
  translate(pipa.x, pipa.y);
  // rotate(rotation);
  imageMode(CENTER);
  image(topImage, 0, 0, scaledWidth, scaledHeight);
  pop();
}

window.addEventListener('mousemove', (ev) => {
  // console.log(ev.y)
  // console.log(ev.x)
  document.querySelector('.cursor').style.top = ev.y + 'px'
  document.querySelector('.cursor').style.left = ev.x + 'px'
})