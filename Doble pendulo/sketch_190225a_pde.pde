float x1,x2,y1,y2, g;
int m1,m2;
int l1,l2;
float a1,a2;
float v_a1, v_a2;
float time=0.200;

PGraphics canvas;
void setup(){
  size(600, 400);
  
  
  a1=PI/2; a2=PI/2;
  m1=40; m2=50;
  g=9.8;
  l1=100; l2=100;
  v_a1=0; v_a2=0.5;
  
  x1=l1*sin(a1);
  y1=-l1*cos(a1);
  
  x2=x1+l2*sin(a2);
  y2=y1-l2*cos(a2);
  
  canvas = createGraphics(600,400);
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
}

void draw(){
  
  background(255);
  image(canvas,0,0,width,height);
  translate(width/2, height/3);
  x1=l1*sin(a1);
  y1=-l1*cos(a1);
  
  x2=x1+l2*sin(a2);
  y2=y1-l2*cos(a2);
  
  
  line(0,0,x1,-y1);
  ellipse(x1,-y1,m1,m1);
  line(x1,-y1,x2,-y2);
  ellipse(x2,-y2,m2,m2);
  
  
  float nu1 = -g*(2*m1+m2)*sin(a1);
  float nu2 = -m2*g*sin(a1-2*a2);
  float nu3 = -2*sin(a1-a2)*m2* ((v_a2*v_a2)*l2+(v_a1*v_a1)*l1*cos(a1-a2));
  float nu4 =  l1*(2*m1+m2-(m2*cos(2*a1-2*a2)));
  
  float nu5 = 2*sin(a1-a2);
  float nu6 = (v_a1*v_a1)*l1*(m1+m2);
  float nu7 = g*(m1+m2)*cos(a1);
  float nu8 = (v_a2*v_a2)*l2*m2*cos(a1-a2);
  float nu9 = l2*(2*m1+m2-m2*cos(2*a1-2*a2));
  
  float a_a1 = (nu1+nu2+nu3)/nu4;
  float a_a2 = (nu5*(nu6+nu7+nu8))/nu9;
  
  v_a1 +=( a_a1*time);
  v_a2 +=( a_a2*time);
  
  a1+=(v_a1*time);
  a2+=(v_a2*time);
  
 
  
  
  
  
  canvas.beginDraw();
  canvas.translate(width/2,height/3);
  canvas.strokeWeight(3);
  canvas.stroke(color(0,0,255));
  canvas.point(x2,-y2);
  canvas.stroke(color(255,0,0));
  canvas.point(x1,-y1);
  canvas.endDraw();
}
