


let x=0.1;
let y=0.0;
let z=0.0;

let a = 10;
let  b = 28;
let c = 8.0/3.0;

let permiso = false;


let iteraciones = 100;
let n = 0;
let points = [];

function setup(){
  createCanvas(600,600,WEBGL);  
  frameRate(60);
  background(0);
  colorMode(HSB);
  frameRate(60);
  //fullscreen(true);
}

function draw(){
  
  if(permiso){
  
 background(0);
  
 
 for(let i=0; i<6; i++){
  
    let dt = 0.01;
    let dx = (a * (y - x))*dt;
    let dy = (x * (b - z) - y)*dt;
    let dz = (x * y - c * z)*dt;
    x = x + dx;
    y = y + dy;
    z = z + dz;
   
    
    points.push(createVector(x,y,z));
   }
  
  orbitControl();
  translate(-width/20,-width/20);
  //rotateX(PI/2);
  rotateY(frameCount * 0.02);
  
 //print(points)
  
  scale(4);
  strokeWeight(2);
  noFill();
  
  
    
    
    for(let i=0; i<points.length-1; i++){
      
   
      //print(c1);
      stroke(i%360,360,360);
      line( points[i].x,
            points[i].y,
            points[i].z,
            points[i+1].x,
            points[i+1].y,
            points[i+1].z
          );
       
    }
    if(points.length >= 300){
     points = points.slice(6,points.length-1);
    }
  
  }
}
function mouseClicked(){
  permiso=true;
}
