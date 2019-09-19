class Palillo{
  int x1,y1;
  int x2,y2;
  boolean nuevo;
  int direction;
  
  Palillo(int x1, int y1, int x2, int y2, int direction){
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
    this.direction = direction;
    this.nuevo=true;    
  
  }
  //a y b como la cordenada de donde pintarlo
  void printPalillo(float factor){
    stroke(color(map(this.x1,-1000,1000,0,255),map(this.x1/3,0,1000,0,255),0));
    strokeWeight(1/factor);
    
    //ellipse(this.x1,this.y1,2,2);
    line(this.x1, this.y1, this.x2, this.y2);
    //ellipse(this.x2,this.y2,2,2);
    
  }
  


}
