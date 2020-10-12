/*

MP3 player project
Im trying to build a full mp3 player javascript app
using p5.js.

revision 1.0
-----------------------------------------
Added :
     * hud
     * time_left
     * prev-next song etc
     * correction in the display of the ring
-----------------------------------------

revision 1.1
-----------------------------------------
Added:
    * upload song button
    * name_tag for the songs
    * display of the song's name above the duration bar

revision 1.2
-----------------------------------------
Added:
    * Functional menu, now all the songs are listed and can be clicked
      in order to reproduce it.

TODO: 
  * add loop button---------------------
  * improve the selection menu---------- V
  * add effects menu-------------------- V
  * add option to hide hud--------------
  * add song by dialog------------------ V
*/


let sound, sound1, sound2, sound3;
let playList;
let indice = 0;
let fft;
let radius = 150;
let particles = [];
let nparticles = 30;
let namePosition;

//for uploading songs
let inp;
let label;


//utilities
function getRandomInt(min, max) {
  return Math.floor(Math.random() * (max - min)) + min;
}

function listSongs(){
  for(let i=0; i<playList.length; i++){
    console.log("track "+i+" "+playList[i].name);
  }
}

//callback for uploading song
function handleFile(file) {
  print(file);
  if(file.type === "audio"){
    playList.push(loadSound(file));
    console.log(playList.length +" "+ "check");
    playList[playList.length-1].name = file.name;
    listSongs();
    initializeList();
  }
  
}

function initializeUploadButton(){
  //upload button add true after handleFile to permit multiple files
 
  
  label =  createElement('label', 'uploadSong')
  inp = createFileInput(handleFile, true);
  inp.id("uploadSongButton");
  
  //inp.position(0, 0);
  label.position(50 ,height );
  
  label.style("display","inline-block");
  label.style("padding","0.35em 1.2em");
  label.style("border", "0.1em solid #F2A3B3");
  label.style("margin", "0 0.3em 0.3em 0");
  label.style("border-radius","0.12em");
  label.style("box-sizing","border-box");
  label.style("text-decoration", "none");
  label.style("font-family","'Roboto',sans-serif");
  label.style("font-weight", "300");
  label.style("color", "#FFFFFF");
  label.style("text-align", "center");
  label.style("transition", "all 0.2s;");
  
  label.child(inp);
  inp.hide()
  
  label.parent(sideNavigation);
}

function initializeList(){
  for(let i=0; i<playList.length; i++){
    
      if(document.getElementById(i)===null){
        
        let songName = playList[i].name;
        if (songName === undefined) songName = "song "+i;
        let lbl = createElement('label', songName);
        lbl.id(i);
        
        lbl.position(50, 50 + 40* i );
        lbl.style("font-family","'Roboto',sans-serif");
        lbl.style("font-weight", "300");
        lbl.style("color", "#FFFFFF");
        //lbl.style("text-align", "center");
        //lbl.mouseReleased(jump_to_song(i));
        lbl.parent(sideNavigation);
        
        //i don't know why i cannot bind a function with parameter like 'jump_to_song(index)'
        //to a onclick listener so i have to do it like this, pretty nasty if u ask me
        document.getElementById(i).onclick = function(){
            print("mek");
            sound.playMode('restart');
            sound.stop();
            sound = playList[i];
            sound.play();
            indice = i;
        }
      }
    }
}

//control
function togglePlay() {
  if (sound.isPlaying()) {
    sound.pause();
  } else {
    sound.play();
  }
}

function doubleClicked(){
  togglePlay();
}

function touchStarted(){
  
  //move in duration bar
  if(mouseY < height && mouseY > height - 25){
    //can click on duration_bar
    let moment = map(mouseX, 10, width-10, 0, sound.duration());
    sound.playMode('restart');
    sound.stop();
    sound.jump(moment);
  }
  
  //previous_song button 
  if(mouseY <= height-49 && mouseY >= height-71 && mouseX <= 32 && mouseX >= 5){
    
    indice --;
    if(indice < 0) indice = playList.length - 1;
    console.log("patras, PISTA "+indice);
    sound.playMode('restart');
    sound.stop();
    sound = playList[indice];
    sound.play();
  }
  //next_song button
  else if(mouseY <= height-49 && mouseY >= height-71 && mouseX <= 75 && mouseX >= 48){
    indice ++;
    if(indice == playList.length) indice = 0;
    console.log("palante, PISTA "+indice);
    
    
    sound.playMode('restart');
    sound.stop();
    sound = playList[indice];
    sound.play();
  }
}

//particles (background)
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

function drawShape(position, r_, angle){
let r = r_;
  fill(position.y);
  push();
  //position.rotate(Math.random(-0.1,0.1));
  translate(position.x, position.y);
  rotate(angle);
  beginShape();
    for(let i=0; i<10; i++){
      vertex(cos(2*PI*i/9)*r, sin(2*PI*i/9)*r);
    }
  endShape(CLOSE);
  pop();
}

function drawParticles(){
  for(let i=0; i<particles.length; i++){
    stroke(255);
      drawTriangle(particles[i].position, 
                   particles[i].r, 
                   particles[i].angle
      );         
  }
}

//music_ring
function draw_music_ring(){
  
  let aux_ang = 0;
  let spectrum = fft.analyze();

  translate(width/2, height/2);
  fill(0);
  circle(0,0,radius*2);
  //serpiensky
    stroke(map(spectrum[0], 0, 255, 360,0),180,180);
    
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
    
    let h =  map(spectrum[i], 0, 255, 0, radius);
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
    
    aux_ang += i*PI*16/(spectrum.length);
    rotate(aux_ang);
  }
  
  
  
}

//hud
function draw_duration_pointer(){
  fill(360, 180,360);
  circle(map(sound.currentTime(), 0, sound.duration(), 10, width-10),height-20, 20);
  
}

function draw_control_bar(){

  //draw bar
  stroke(255);
  strokeWeight(10);
  line(10, height-20, width-10, height-20);
  stroke(360, 180, 360);
  line(
       10, height-20, 
       map(sound.currentTime(), 0, sound.duration(), 10, width-10),
       height-20
  );
  
  //draw next and previous_song button
  fill(360, 180, 360);
  drawTriangle(createVector(20, height-60), 3, -PI/2);
  drawTriangle(createVector(60, height-60), 3, PI/2);
  strokeWeight(1);
  line(32, height-49, 32, height-71);
  line(48, height-49, 48, height-71);
  stroke(255);
  
  
  //draw time left
  let t = new Date((sound.duration() - sound.currentTime()) * 1000).toISOString().substr(11, 8);
  text( t, width-60, height-40);
  
}

function draw_song_name(){
  
  let songName = playList[indice].name;
  if (songName === undefined) songName = "song "+indice;
  text(songName,namePosition, height-40);
  namePosition--;
  if(namePosition == 70) namePosition = width - 80;
}

//events
function preload(){
  sound1 = loadSound('vsad.mp3');
  sound2 = loadSound('intro.mp3');
  sound3 = loadSound('cancaneo.mp3');
  playList= [sound1, sound2, sound3]
}

function setup() {
  createCanvas(980, 720);
  colorMode(HSB,360);
  
  sound = sound1;
  
  fft = new p5.FFT();
  sound.amp(0.2);
  for(let i=0; i<nparticles; i++){
    particles.push(
      {
        position : createVector(Math.random(0,1)*width,Math.random(0,1)*height),
        r: getRandomInt(1,6),
        angle: PI*i/250
      }
    );
  }
  /*
  //select song 
  sel = createSelect();
  //sel.position(10, 10);
  sel.option('vsad');
  sel.option('intro');
  sel.option('cancaneo');
  sel.changed(mySelectEvent);
  */
  
  namePosition = width/2;
  
  initializeUploadButton();
  
  listSongs();
  
  initializeList();
  
}

function mySelectEvent() {
  sound.stop();
  let item = sel.value();
  switch(item){
    case 'vsad' :
      sound = sound1;
    break;
    case 'intro' :
      sound = sound2;
    break;
    case 'cancaneo' :
      sound = sound3;
    break;
  }
}

function draw() {
  
  background(0);
  drawParticles();
  updateParticles();
  draw_control_bar();
  draw_song_name();
  draw_duration_pointer();
  stroke(0);
  draw_music_ring();
  //sld.value(sound.currentTime());
 
  
}
