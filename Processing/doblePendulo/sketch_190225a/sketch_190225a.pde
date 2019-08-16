

float l=30.0;
float anguloA=60;
float anguloB=60;

float x1 = l/2 *sin(anguloA);
float y1 = -l/2 *cos(anguloA);


float x2 = l*(sin(anguloA)+0.5*sin(anguloB));
float y2 = -l*(cos(anguloA)+0.5*cos(anguloB));

void setup(){
  size(600,600);
  background(255);
  stroke(0);
  ellipse(300,10,4,4);

}
void draw(){
  translate(300,300);
  stroke(0);
  fill(0);
  ellipse(x1,y1,4,4);
  ellipse(x2,y2,4,4);
  print("x1-> "+x1+"y1-> "+y1);
  
}
