import peasy.*;

final int detail = 150;
final int radius_ = 50;
PVector[][] sphere;
boolean debug = false;
/**
* calculateSpherePoints(int, l, int rm, rM)
*  return a matrix of PVectors containing the
*  the 3D collection points, there is also an integrated
*  terrain generator using Perlin Noise 
*
* Arguments:
*  l, as the shape's level of Detail,
*  rm, as the minimum value for the radius of the sphere
*  rM, as the maximim value for the radius of the sphere
**/

PVector[][] calculateSpherePoints(int lvlOfDetail, int radius, int radiusM){

  PVector[][] glob = new PVector[lvlOfDetail][lvlOfDetail];
  float scl = 6.0; //controls the excentricity of the noise
  
  for(int i=0; i<lvlOfDetail; i++){
    float theta = map(i, 0, lvlOfDetail - 1, -PI, PI);
    if(i==0 || i==lvlOfDetail-1)theta += PI/lvlOfDetail; //edge case control
    for(int j=0; j<lvlOfDetail; j++){
      float phi = map(j, 0, lvlOfDetail - 1, -HALF_PI, HALF_PI);
      if(j==0|| j==lvlOfDetail-1)phi += PI/lvlOfDetail; //edge case control
          float rad = map (
                    noise(
                       sin(theta) * cos(phi) * scl +radius,
                       sin(theta) * sin(phi) * scl +radius,
                       cos(theta) * scl +radius 
                    ), 0, 1, radius, radiusM
                  );
       float x = rad * sin(theta) * cos(phi);
       float y = rad * sin(theta) * sin(phi);
       float z = rad * cos(theta);
       
       glob[i][j] = new PVector(x,y,z);
       
     }
  }
  return glob;
}
/**
*This method has to be cast after a previous calculation of the Sphere 3D points,
*given as the argument.
*
*draw_glob(PVector[][] p)
*
*Arguments:
*  p, as the calculated points matrix
**/

void draw_glob(PVector[][] points){
  for(int i=0; i<points.length; i++){
    for(int j=0; j<points[i].length; j++){
      
      PVector p = points[i][j];
      //triangular mesh
      float mean = p.mag();
      int divs = 1;
      beginShape(TRIANGLES);
      vertex(p.x,p.y,p.z);
        if( i+1 < points.length){ //&& j+1 >= points[i].length){
          PVector p2 = points[i+1][j];
          vertex(p2.x, p2.y, p2.z);
          mean += p2.mag();
          divs++;
        }
        if( j+1 < points[i].length){ //&& i+1 >= points[i].length){
          PVector p3 = points[i][j+1];
          vertex(p3.x, p3.y, p3.z);
          vertex(p3.x, p3.y, p3.z);
          mean += p3.mag();
          divs++;
        }
        if( i+1 < points.length){ //&& j+1 >= points[i].length){
          PVector p2 = points[i+1][j];
          vertex(p2.x, p2.y, p2.z);
          mean += p2.mag();
          divs++;
        }
        if(i+1 < points.length && j+1 < points[i].length){
          PVector p4 = points[i+1][j+1];
          vertex(p4.x, p4.y, p4.z);
          mean += p4.mag();
          divs++;
        }
        
        mean /= (float)divs;
        if(mean - radius_ >= 5 && mean - radius_ < 6 )
          fill(color(20, map(mean, radius_, radius_ + 10, 240, 80)  ,20));
        else if(mean - radius_ >= 6 && mean - radius_ < 7)
          fill(color(map(mean, radius_, radius_ + 10, 100, 80), 48,48));
        else if(mean - radius_ >= 7)
          fill(color(255,255,255));
        else
          fill(color(0, 0 ,map(mean, radius_, radius_ + 10, 100, 240) ));
      endShape();
    }
  }  
}

void setup(){
  //noiseSeed(123456789);
  size(600,600,P3D);
  PeasyCam cam = new PeasyCam(this,100);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(2000);
  sphere = calculateSpherePoints(detail,radius_, radius_+10);
  stroke(0);
  strokeWeight(1);
  noStroke();
  fill(255);
  //print(sphere.length, sphere[19].length);
}
void draw(){
  background(0);
  lights();
  draw_glob(sphere);
  
  if(debug){
    stroke(color(255,0,0));
    line(0,0,0, 500, 0,0);
    stroke(color(0,0,255));
    line(0,0,0,0,500,0);
    stroke(color(0,250,0));
    line(0,0,0,0,0,500);
    noStroke();
  }
}
