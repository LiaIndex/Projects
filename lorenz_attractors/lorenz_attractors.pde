


float x=0.1;
float y=0;
float z=0;

float a = 10;
float  b = 28;
float c = 8.0/3.0;




int iteraciones = 100;
int n = 0;
ArrayList<PVector> points = new ArrayList<PVector>();

void setup(){
  size(600,400,P3D);  
  frameRate(60);
  background(0);
}

void draw(){
 background(0);
 
 for(int i=0; i<20; i++){
  
    float dt = 0.01;
    float dx = (a * (y - x))*dt;
    float dy = (x * (b - z) - y)*dt;
    float dz = (x * y - c * z)*dt;
    x = x + dx;
    y = y + dy;
    z = z + dz;
   
    
    points.add(new PVector(x,y,z));
   }
 
 
  translate(width/2,height, -90);
  rotateX(PI/2);
  
  
 
  
  scale(7);
  strokeWeight(0.07);
  noFill();
  beginShape();
    int iter = 0;
    for(PVector p : points){
       if(iter < points.size()*0.25){stroke(255,0,0);}
       else if(iter < points.size()*0.50){stroke(0,255,0);}
       else if(iter < points.size()*0.75){stroke(0,0,255);}
       else{stroke(iter*random(0,255)+iter*random(0,255)+iter*random(0,255));}
       vertex(p.x,p.y,p.z);
       iter++;
    }
  endShape(); 
}
