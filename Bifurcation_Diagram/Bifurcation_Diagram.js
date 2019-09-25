let x = 0.1;
let i = 0;
let offset = 300;
let r;

function setup() {
  createCanvas(800, 400); 
}

function mouseClicked() {
  background(255);
  loop();
}

function draw() {
    
  noStroke();
  rect(0,0,150,50);
  text('r: '+r+'\nx: '+x, 10, 30);
  
  for(let j=0; j<500; j++){
    stroke(0,200);
    r = map(i+offset, 0, width, 2, 4);
    let nx =r*x*(1-x);
    let mnx = map(nx, 0, 1, 0, height);
  
  
    point(i, mnx);
    i+=0.009;
    x = nx;
    if(r>=4){i=0; noLoop();}
  }
  
}
