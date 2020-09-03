import peasy.*;
PVector[] points_;

PVector[] generatePoints(int numberOfPoints){
    PVector[] points = new PVector[numberOfPoints];
    float gr = (float) (3-Math.sqrt(5));
    float lambda = PI * gr;
    
    for(int i=0; i<numberOfPoints; i++){
      float t = (float)i/numberOfPoints;
      float a1 = acos(1-2*t);
      float a2 = lambda * i;
      float x = sin(a1) * cos(a2);
      float y = sin(a1) * sin(a2);
      float z = cos(a1);
      PVector p = new PVector(x,y,z).mult(30);
      points[i] = p;
               
    }
    return points;
}


void setup(){
    
   size(600,600,P3D);
   PeasyCam cam = new PeasyCam(this,100);
   cam.setMinimumDistance(50);
   cam.setMaximumDistance(500);
   points_ = generatePoints(1000);
}
void draw(){

  background(0);
  stroke(255);
  strokeWeight(2);
  for(int i=0; i<points_.length; i++){
 
  point(points_[i].x,
        points_[i].y,
        points_[i].z);
  }
  
}
