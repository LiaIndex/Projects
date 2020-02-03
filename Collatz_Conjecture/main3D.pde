import peasy.*;

/*
*  Example of Collatz conjecture
*  Author: Lia Belda Calvo
*  references: 
*    
*    https://en.wikipedia.org/wiki/Collatz_conjecture
*    https://www.youtube.com/watch?v=LqKpkdRRLZw
*      
*/

int quantity = 2;
ArrayList<FloatList> matriz = new ArrayList();
int omega =6000;
//let  slider;
int red_ = 250;
int blue_ = 0;
float x_, y_, z_;
ArrayList<point_> toDraw = new ArrayList();
PeasyCam cam;

/**
*  return an array containing the i angle of rotation 
*  correspondent to the i element of the Collatz path for the 
*  given number n.
*
*   n = 2; result = [ 0.20-(0.0002*0) ]
*   n = 3; result = [ 
*                    -0.19-(0.00025 * 0),
*                    -0.19-(0.00025 * 1),
*                     0.20-(0.0002  * 2),
*                     0.20-(0.0002  * 3),
*                     0.20-(0.0002  * 4)
*                   ]
**/
void doCollatz (int n){
  int aux = n;
  float angle;

  FloatList result = new FloatList();
  float a1 = PI/13;
  float a2 = -PI/20;
  result.push( n%2 == 0 ? a1 : a2 );
  
  while( aux != 1 ){
    if(aux %2 == 0){
      aux /= 2;
      angle = a1;
    }
    else{
      //canonic is 3n+1 but with /2 is more aesthetic
      aux =( aux * 3 +1 ) /2;
      angle = a2;
    }
    result.push(angle);
  }
  result.reverse();
 matriz.add(result);
}

void mouseDragged() {
 // background(40);
}

void setup() {
  
  size(800, 800,P3D);
  background(40);
 // slider = createSlider(1,7500,99);
  for ( int i = 1000; i<20000; i++){
    doCollatz(i);
  }
  rectMode(CENTER);
  cam = new PeasyCam(this, 250);
  cam.setMinimumDistance(5);
  cam.setMaximumDistance(5000);
  colorMode(HSB, 100);
}
boolean cw=true;
void draw() {
  //translate(width/2,height/2);
  background(40);
  //();
  
  strokeWeight(1);
  //directionalLight(250, 250, 250, 200, 0, 0);
  //directionalLight(250, 250, 250, -200, 0, 0);

  //rotateY(-millis() / 1000);
  //rotateZ(millis() / 1000);
  
  
  scale(0.75);
  if(cw){
  for(int i=matriz.size()-omega; i<matriz.size(); i++){
    pushMatrix();
         
  
         for(int j=0; j<matriz.get(i).size(); j++){
           float an_ = matriz.get(i).get(j); 
           rotateX(an_);
           rotateY(an_);
           rotateZ(an_);
            //line(0,0,0,0,-quantity,0);
            x_ = modelX(0,0,0);
            y_ = modelY(0,0,0);
            z_ = modelZ(0,0,0);
            toDraw.add(new point_(x_,y_,z_));
            //vertex(x_,y_,z_);
            translate( 0, -quantity,0);
          }
          
    popMatrix();
  }
  cw = false;
 
  }
  noFill();
  beginShape();
  for(int k=0; k<toDraw.size(); k++){
    if(toDraw.get(k).x == 0.0 && toDraw.get(k).y == 0.0 && toDraw.get(k).z == 0.0){
      
      endShape();
      beginShape();
      stroke(k%10,k%50,100,100);
    }
    vertex(toDraw.get(k).x,toDraw.get(k).y,toDraw.get(k).z);
  }
 
    //doCollatz(omega);
    //omega++;
  
}
class point_{
  float x;
  float y;
  float z;
  point_(float x_, float y_, float z_){
    x = x_;
    y = y_;
    z = z_;
  }
}
