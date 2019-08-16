ArrayList<Palillo> palos = new ArrayList<Palillo>();
ArrayList<Palillo> next = new ArrayList<Palillo>();
int len = 40;
float minX =  -width/2;
float  maxX = width/2-1;
float factor =10;

void setup(){
  
  background(255);
  //size(1000,1000);
   fullScreen(P2D);
  //translate(width/2,height/2);
  Palillo p = new Palillo(0,0,0,len,-1);
  
  
  p.printPalillo(factor);
  
  
  palos.add(p);
  frameRate(60);
}
void draw(){
    background(255);
   
    translate(width/2,height/2);
    scale(factor);
    generate();
    
    for(Palillo p : palos){
        minX = min(p.x1,minX);
       maxX = max(p.x1,maxX);
       factor= float(width)/(maxX-minX);
       p.printPalillo(factor);
      
       //
       
       //translate(width/2,height/2);
      
    }
    
 
 
}

boolean isVertexFree(int x, int y, Palillo instancia){
  Palillo aux;  
  for(int i=0; i< palos.size(); i++){
      aux=palos.get(i);
      //comprobar que no encuentre a quien llama al metodo
      if(!aux.equals(instancia)){
        //if(palos.get(i).nuevo==ttr)return false;
        if(aux.x1==x && aux.y1==y)return false;
        if(aux.x2==x && aux.y2==y)return false;
        
        
      }
    
    
    }
  
    return true;
}
/*
boolean[] isVertexFreev2(Palillo p){
  if(p.nuevo==true){
    int x1 = p.x1;
    int y1 = p.y1;
    int x2 = p.x2;
    int y2 = p.y2;
    boolean[] v={true,true};
    for(Palillo pi : palos){
      if(!pi.equals(p)){
        
        if(pi.x1==x1 && pi.y1==y1)v[0]= false;
        if(pi.x2==x1 && pi.y2==y1)v[= false;
        
        if(pi.x1==x1 && pi.y1==y1)v2= false;
        if(pi.x2==x1 && pi.y2==y1)v2= false;
        
      }
    
    }
  
  }
  return 
}*/

void generate(){
  for(Palillo palo  : palos){
   
    if(palo.nuevo==true){
      if(isVertexFree(palo.x1,palo.y1,palo)){
        //depie 
        if(palo.direction == -1){
         
           next.add(
             new Palillo ( palo.x1-len/2, palo.y1, palo.x1+len/2, palo.y1, 1)
             );
         }
         //tumbado
         else{
           next.add(
             new Palillo ( palo.x1, palo.y1-len/2, palo.x1, palo.y1+len/2, -1)
             );
         }
         palo.nuevo=false;
         
      }
      if(isVertexFree(palo.x2,palo.y2,palo)){
        //depie 
        if(palo.direction == -1){
          
           next.add(
             new Palillo ( palo.x2-len/2, palo.y2, palo.x2+len/2, palo.y2, 1)
             );
             
         }
         //tumbado
         else{
           next.add(
             new Palillo ( palo.x2, palo.y2-len/2, palo.x2, palo.y2+len/2, -1)
             );
             
         }
         palo.nuevo=false;      
      }
      //print y scale
       
    }
    
       
       
   
    
  }
      
  palos.addAll(next);
  next = new ArrayList<Palillo>();
}
