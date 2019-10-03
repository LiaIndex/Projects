

/*version sin workers, quitar script de worker en index*/


let width=1200;
let height=1200;
let iteraciones=500;
var bright;
var a; 
var b; 
var ca;
var cb;

var aa;
var bb;

var mapMaxX=2;
var mapMaxY=2;
var mapMinX=-2;
var mapMinY=-2

let xZonaNula;
let yZonaNula=80;



function setup(){
    
    
    createCanvas(width,height);
    input = createInput();
    input.position(20, 65);
  
    button = createButton('submit');
    button.position(input.x + input.width, 65);
    button.mouseClicked(greet);
    xZonaNula=input.x + input.width +button.x+button.width +10;  
    
  }
  
  function greet(){
      
      if(input.value!=''){
          print(input.value.parseInt);
          iteraciones=parseInt(input.value());
          input.value='';
          loop();
      } 
     
  }
let x= 0;

function draw(){
    if(x==width){noLoop();}
    if(x%200==0){updatePixels();}
    for( let y=0; y<height; y++){

        a=map(x, 0, width, mapMinX, mapMaxX);
        b=map(y, 0, height, mapMinY, mapMaxY);

        ca = a;
        cb = b;
        let n=0;
        while (n<iteraciones){
                
            aa =  a *a-b *b;
            bb = 2  * a * b;
        
             a= aa+ca;
             b= bb +cb;
        
             if(((a*a)+(b*b))>=4){
                 break;
             }
        
             n++;
        }

        bright =color(map(n, 0, iteraciones, 0, 255),map(n, 0, iteraciones, 0, 100),map(n, 0, iteraciones, 0, 200));
        if(n==iteraciones){ bright=0;   }
        set(x,y,color(bright));
    }
    x++;
}
function mouseClicked() {
    
        print(mouseX+" "+mouseY);
        if(mouseX<=xZonaNula && mouseY<=yZonaNula){}
        else{
        
            let nex = map(mouseX,0,width,mapMinX,mapMaxX);
            let ney = map(mouseY,0,height,mapMinY,mapMaxY);

            let dx= (mapMaxX-mapMinX)/20
            let dy= (mapMaxY-mapMinY)/20;

            mapMinX = nex -dx;
            mapMinY = ney -dy;

            mapMaxX = nex +dx;
            mapMaxY = ney +dy;          
            
            loop();
        }
}

/*

to observ the pattern of the stable numbers of the set
todo: https://www.youtube.com/watch?v=FFftmWSzgmk

void mouseClicked() {
  
  float a_ = map(mouseX,0,width,-2,2);
  float b_ = map(mouseY,0,height,-2,2);
  
  int it = 0;
  
  float ca_ = a_;
  float cb_ = b_;
  
  while(it<50){
    
    float na_ = (a_*a_-b_*b_)+ca_;
    float nb_ = (2*a_*b_)+cb_;
    
    stroke(255,140);

    line(
      map(a_,-2,2,0,width),
      map(b_,-2,2,0,height),
      map(na_,-2,2,0,width),
      map(nb_,-2,2,0,height)
    );
  
    fill(255);
    ellipse(mouseX,mouseY,5,5);
    it++;
    a_=na_;
    b_=nb_;
  }
  
  updatePixels();
}*/
