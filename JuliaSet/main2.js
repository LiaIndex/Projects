

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
      } /*print("pene");*/
     
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
    /* let xM = mouseX;
        let yM =  mouseY;*/
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

        // print("X raton : "+nex+" y raton : "+ney);

            
            
            loop();
        }
}