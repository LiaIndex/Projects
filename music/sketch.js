/*
Author: Lia Belda Calvo
example of mp3 player
song: do you feel it - Chaos Chaos
everything is done with the p5 sound library, TODO implement mine fft
*/
let sound;
let fft;
let radius = 100;
let particles = [];

function getRandomInt(min, max) {
  return Math.floor(Math.random() * (max - min)) + min;
}
function togglePlay() {
  if (sound.isPlaying()) {
    sound.pause();
  } else {
    sound.loop();
  }
}
function touchStarted(){
  togglePlay();
}
function updateParticles(){
  for (let i=0; i<particles.length; i++){
    particles[i].position.y -= 1;
    if(i%2==0)
       particles[i].angle += PI/250;
    else
       particles[i].angle -= PI/250;
    if (particles[i].position.y <=0)           
      particles[i].position.y = height;
  }
}
function drawTriangle(position, r_, angle){
  let r = r_;
  fill(position.y);
  push();
  //position.rotate(Math.random(-0.1,0.1));
  translate(position.x, position.y);
  rotate(angle);
  beginShape();
    vertex(0,0 - r);
    vertex(0 - r, 0+r);
    vertex(0 + r, 0+r);
  endShape(CLOSE);
  pop();
}
function drawParticles(){
  for(let i=0; i<particles.length; i++){
    stroke(255);
    drawTriangle(particles[i].position, particles[i].r, particles[i].angle);
  }
}
function preload(){
  sound = loadSound('cancion.mp3');
}
function draw_music_ring(){
  
  let aux_ang = 0;
  let spectrum = fft.analyze();

  translate(width/2, height/2);
  fill(0);
  circle(0,0,radius*2);
  //serpiensky
    stroke(map(spectrum[0], 0, 255, 360,0),180,360);
    drawTriangle({x:0, y:0}, 20, 0);
    rotate(PI);
    drawTriangle({x:0, y:-10}, 10, 0);
    drawTriangle({x:-10, y:-15}, 5, 0);
    drawTriangle({x:10, y:-15}, 5, 0);
    drawTriangle({x:0, y:5}, 5, 0);
    rotate(-PI);
  fill(255);
  rotate(-PI/2);
  noStroke();
  
  for (let i = 0; i< spectrum.length; i++){
    //let x = map(i, 0, spectrum.length, 0, width);
    
    let h =  map(spectrum[i], 0, 255, 0,radius);
    let bright =  map(spectrum[i], 0, 255, 360,0);
    fill(bright,180,360);
    
    //      5px
    //      ^
    //    -----
    //     / \     | 
    //     | |     |->h
    //     | |     |
    beginShape();
     vertex(radius,0);
     vertex(radius+h, 0);
     vertex(radius+h+5, 2.5);
     vertex(radius+h, 5);
     vertex(radius,5);
    endShape(CLOSE);
    
    aux_ang += PI/(spectrum.length/2);
    rotate(aux_ang);
  }
  
  
  
}

function setup() {
  createCanvas(400, 400);
  colorMode(HSB,360);
  fft = new p5.FFT();
  sound.amp(0.2);
  for(let i=0; i<20; i++){
    particles.push(
      {
        position : createVector(Math.random(0,1)*width,Math.random(0,1)*height),
        r: getRandomInt(2,10),
        angle: 0
      }
    );
  }
}
function draw() {
  
  background(0);
  
  drawParticles();
  updateParticles();
  
  stroke(0);
  
  draw_music_ring();
  
}
