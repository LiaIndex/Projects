int maxX = 2;
int maxY = 3;
int iteraciones=0;
ArrayList<PVector> points1 = new ArrayList<PVector>();
ArrayList<PVector> points2 = new ArrayList<PVector>();

void setup(){
  size(400,400);
  background(0);
  for(int x=0; x<width; x++){
    
      float mapedX = map(x, 0, 375, -maxX, maxX);
      float mapedY1 =-map(sqrt( (1 - pow( (abs(mapedX) - 1),2) ) ), -2, 2, 0, height);
      float mapedY2 =-map(acos(1 - abs(mapedX)) - PI , -2, 2, 0, height);
    
      points1.add(new PVector(x, mapedY1));
      points2.add(new PVector(x, mapedY2));
      
      println(mapedX+" "+mapedY1);
  }
}


void draw(){
 
 background(0);
 translate(15,300);
 // translate(width/2, height/2);
  
  stroke(color(iteraciones,0,0));
  fill(color(iteraciones,0,0));
  beginShape();
    for(int i=0; i<iteraciones; i++){
      
      vertex(points1.get(i).x, points1.get(i).y);
    }
    
    for(int j=0; j<iteraciones; j++){
       vertex(points2.get(j).x, points2.get(j).y);  
    }
  endShape();
  iteraciones++;
  if(iteraciones == points1.size()){noLoop();}
}
