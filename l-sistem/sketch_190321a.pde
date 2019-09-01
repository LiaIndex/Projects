char[] axioms = /*{'A','B','+','-','[',']'}*/{'X','F','+','-','[',']'};
String[] rules = /*{"B-A-B","A+B+A","+","-","[","]"} ;*/{"F+[[X]-X]-F[-FX]+X","FF","+","-","[","]"};
String axioma = /*"A";*/"X";
int iteraciones =9;
float angle=0.138*PI;


int cont=0;
int control=0;
int len=2;

float minX =  -width/2;
float  maxX = width/2-1;
float factor=5;
String axioma2=axioma;
void setup(){
  size(1080,720);
  background(255);
  
  /*
  while(cont<iteraciones){
    axioma=itera(axioma2);
    axioma2=axioma;
    //print(axioma,"\n");
    cont++;  
  }*/
 
  /*
  scale(factor);*/
  
  
}
void draw(){
  
    if(cont<iteraciones){
      axioma=itera(axioma2);
      axioma2=axioma;
      cont++;
  
    translate(width*0.5,height);
    rotate(-PI/2);
    //factor*=0.01;
    //print("echo");
    for(int i=0; i<axioma.length();i++){
    
    
    
    //print();
    if(axioma.charAt(i)=='F'||axioma.charAt(i)=='G'){
      
      line(0,0,len,0);
      translate(len,0);
      
      
    }
    else if(axioma.charAt(i)=='+'){
      //print("rota+");
      rotate(angle);
      
    }
    else if(axioma.charAt(i)=='-'){
      //print("rota-");
      rotate(-angle);
      
    }
    else if(axioma.charAt(i)=='['){
      //print("rota-");
      push();
      
    }
    else if(axioma.charAt(i)==']'){
      //print("rota-");
      pop();
      
    }
  }
  
delay(500);
}else{
  print(axioma2);
  noLoop();}
}
    

  
  



String itera(String ax){
 String resultado="";

 for(int i=0; i<ax.length(); i++){
   for(int j=0; j<axioms.length; j++){
     if(ax.charAt(i)==axioms[j]) resultado+=rules[j];
     
   }
 }
 return resultado;
}
