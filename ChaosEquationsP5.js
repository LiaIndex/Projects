let x,y,z, tx, ty;
let iteraciones = 0; 
let max = 10;

let mapedX;
let mapedY;



function setup() {
  createCanvas(500, 500);
  
  t = 0.00042;
  x = t;
  y = x;
  tx = t;
  ty= t
  
  
  background(0);
}

function draw() {
   //background(0);
   
  
    strokeWeight(2);
   
    for(let i=0; i<200; i++){
    
    let newX =/*-x*x + x*t +y;*/  -t*t-x*y+t;
    let newY = /*x*x - y*y -t*t - x*y +y*t -x +y;*/-x*y+x*t+y+t;
    let color = random(0,255);
    
    mapedX = map(newX, -t*300, t*300, 0, width);
    mapedY = map(newY, -t*300, t*300, 0, height);
      
     
   
    
    set(mapedX%width,mapedY%height, 255, 150);
   
    
    x=newX;
    y=newY;
    
    
    t+=0.0000000001
    updatePixels();
    }
  
  
  
    
   
  
}
