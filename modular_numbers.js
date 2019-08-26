
let r=0;

let cordinates = [];
let rSlider;
let total = 0;

//factor indicate the number wich is going to multiply all the others, for example, with 2 forms a cardioid
let factor = 2;

function setup() {
  createCanvas(400, 400);
  r = height/2;
  
  rSlider = createSlider(0, 1000, 100);
  rSlider.position(20, 20);
  
}
function getVector(index, total){
  const angle = map(index%total, 0, total, 0, TWO_PI);
  const v = p5.Vector.fromAngle(angle + PI);
  v.mult(r);
  return v;
}

function draw() {
  background(0);
  total = rSlider.value(); 
 

  translate(width/2, height/2);
  stroke(250,155);
  strokeWeight(2);
  noFill();
  ellipse(0,0,r*2);

  strokeWeight(2);
  
  for(let i=0; i<total; i++){
    
    const a=getVector(i, total);
    const b=getVector(i*factor, total);
    line(a.x, a.y, b.x, b.y);
  
  }
  
  /*
  cordinates.push({
          x: a.x,
          y: a.y
     });
  first aprouch of how to get the lines to draw
  for ( let j=0; j<cordinates.length; j++){
    
      if(j*factor >= total){
        line(cordinates[j].x,cordinates[j].y, cordinates[j*factor%total].x, cordinates[j*factor%total].y); 
      }
      else{
        line(cordinates[j].x ,cordinates[j].y, cordinates[j*factor].x, cordinates[j*factor].y); 
      }
    
  }
 
  cordinates = [];
  */
}
