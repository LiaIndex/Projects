let factor = 0;
let r=0;

function setup() {
  createCanvas(400, 400);
  r = height/2;
}
function getVector(index, total){
  const angle = map(index%total, 0, total, 0, TWO_PI);
  const v = p5.Vector.fromAngle(angle + PI);
  v.mult(r);
  return v;
}

function draw() {
  background(0);
  const total = 500; 
  factor += PI/3000;
  
  translate(width/2, height/2);
  stroke(255);
  strokeWeight(2);
  noFill();
  ellipse(0,0,r*2);
  
  strokeWeight(2);
  for(let i=0; i<total; i++){
    const a=getVector(i, total);
    const b=getVector(i*factor, total);
    line(a.x, a.y, b.x, b.y);
  }
}
