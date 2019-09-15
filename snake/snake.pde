


//------------------------------DATA-STRUCTURE-----------------------------------//
//each node of the snake
public class node{
   //position on the array
   int x,y;
   int prevX = x;
   int prevY = y;
   node prev = null;
   node next = null;
   //node constructor
  public node(int x,  int y, node prev){
   this.x = x;
   this.y = y;
   this.prev = prev;
  }
  //head contructor
  public node(int x,  int y){
   this.x = x;
   this.y = y;   
  }  
}
//class snake
public class snk{

  node head = null;
  int size = 0;
  node last = null;
  
  public void addNode(node n){
  
     if(head==null){
       this.head = n;
       n.prev = this.head;
     }
     else{
       node aux = this.head;
       while(aux.next != null){
         aux = aux.next;
       }
       aux.next=n;
       n.prev = aux;
       
     }
     this.last = n;
     size++;
  }
}
//---------------------------END-OF-DATA-STRUCTURE-----------------------------------//

//---------------------------MAIN BLOCK----------------------------------------------//
//rows and columns of the screen
int rows = 10;
int columns = 10;
//codition for one apple to spawn (if is not an apple already)
boolean apple = false;
//x and y position of the apple
int applePos;
//snake structure
snk serp = new snk();





void setup(){
  size(400,400);
  node n1 = new node(rows/2, columns/2);
  serp.addNode(n1);  
}

void keyPressed() {
  actualiceSnk(key);
}

void actualiceSnk(char thekey){
  //variables to determine where will appear the new node to add
  int desplX =0;
  int desplY =0;
  //save state pre-change of head
  serp.head.prevX = serp.head.x;
  serp.head.prevY = serp.head.y;
  
  //w up, s down, d right, a left
  if (thekey == 'w') {
    serp.head.y -= 1;
    desplY = 1;
    if(serp.head.y < 0 ) {serp.head.y = columns -1;}
  }
  else if(thekey == 's'){
    serp.head.y += 1;
    desplY = -1;
    if(serp.head.y == columns) {serp.head.y = 0;}
  }
  else if(thekey == 'a'){
    serp.head.x -= 1;
    desplX = 1;
    if(serp.head.x < 0) {serp.head.x = rows -1;}
  }
  else if(thekey == 'd'){
    serp.head.x += 1;
    desplX = -1;
    if(serp.head.x == rows) {serp.head.x = 0;}
  }
  
  //if the head touches the apple, the snake grows
  
   if(serp.head.x == applePos && serp.head.y == applePos){
      println("ñam");
      apple = false;
      node n2 = new node(serp.last.x+desplX, serp.last.y+desplY);
      serp.addNode(n2);
   }
  
  if(serp.size > 1){
    
    node aux = serp.head.next;
    while(aux!=null){
      //LOSS CONDITION snake touches itself
      if(serp.head.x == aux.x && serp.head.y == aux.y && serp.size>1){
        println("LOOSER");
        noLoop();
      }

      
      //save state pre-change 
      aux.prevX = aux.x;
      aux.prevY = aux.y;
      //update position based on prev position of prev node
      aux.x = aux.prev.prevX;
      aux.y = aux.prev.prevY;
      
      aux = aux.next;
    }
  }//if
}

void draw(){
 
  //draw grid
   fill(255);
  for(int i=0; i<rows; i++){
    for(int j=0; j<columns; j++){
      square((width/rows)*i, (height/rows)*j, (width/rows));
    }
  }
  
  
  //spawn apple if it isnt on the grid
  if(!apple){
     //random position of the apple
     applePos=(int) random(0,rows);
     //print(applePos);
     apple = true;
  }
  //draw the apple
  fill(color(255,0,0));
  square(applePos * width/rows ,applePos * width/rows ,width/rows);
  
 //eat apple and grow
  if(serp.head.x == applePos && serp.head.y == applePos){
    print("ñam");
    apple = false;
    node n2 = new node(serp.last.x-1, serp.last.y);
    serp.addNode(n2);
  }
  
  node aux = null;
  aux = serp.head;
  
  //draw snake
  fill(0);
  while(aux != null){
    
    square(
      aux.x * (width / rows),
      aux.y * (height / columns),
     (width / rows)
    );
    aux=aux.next;
    
  }
  
  delay(100);
}
