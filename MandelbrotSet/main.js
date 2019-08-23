/*
Author: Lia de Belda
Mandelbrot set displayed on JavaScript using P5 Library
version with workers, add workers.js to the sources on the html 


                                        #                   
                                     ..                     
                                   .####                    
                            .     # .##.                    
                             ##*###############.            
                           #.##################             
                          .### MANDELBROT SET ####.          
                 ######.  #######################           
               ##########.######################            
####################### WITH WORKERS !#########              
               ##########.######################            
                 ######.  #######################           
                          .######################.          
                           #.##################             
                             ##*###############.            
                            .     # .##.                    
                                   .####                    
                                     ..                 
*/



let width=1000;
let height=1000;

//max iterations
let iteraciones=1200;


//variable to calculate the color of the pixel
var bright;

//boundaries of the set
var mapMaxX=2;
var mapMaxY=2;
var mapMinX=-2;
var mapMinY=-2

//coordinate y 
let y=0;


/* --TODO--
button to modify the number of iterations on running
------------
let xZonaNula;
let yZonaNula=80;
*/


let myWorker1 = new Worker("worker.js");
let myWorker2= new Worker("worker.js");
let myWorker3 = new Worker("worker.js");
let myWorker4 = new Worker("worker.js");

let workers = [myWorker1,myWorker2,myWorker3,myWorker4];
/*const myWorker5 = new Worker("worker.js");
const myWorker6 = new Worker("worker.js");*/

function setup(){
  createCanvas(width,height);
 /* --TODO--
    button to modify the number of iterations on running
    ------------
  input = createInput();
  input.position(20, 65);

  button = createButton('submit');
  button.position(input.x + input.width, 65);
  button.mouseClicked(greet);
  xZonaNula=input.x + input.width +button.x+button.width +10;  
  */
}

/*
--TODO--
button to modify the number of iterations on running
------------
function greet(){
    
    if(input.value!=''){
        print(input.value.parseInt);
        iteraciones=parseInt(input.value());
        input.value='';
        loop();
    } 
   
}*/

//main loop
function draw(){
    
    //notify to all workers, and send data to calculate the rows if they are free
    for(let i=0; i<workers.length;i++){
        if(workers[i].runing = function(e)  { e.data == true}){
            workers[i].postMessage(y+i);
        }
        //else{print(workers[i].runing);}
    }
       
        
    //finish when all rows are displayed by the workers    
    if(y>=height){
        y=0;
        noLoop();   
    }
    
    //for i workers y+=i
    y+=4;   
 
}


//when the worker send data to the main this happen
myWorker1.onmessage = function(e) {
    //vector containing all the calculated coordinates with the iterations of each one
    let arr=[];
    while(e.data.length>0){
        arr=e.data.pop();
        let x1 = arr.x;
        let y1 = arr.y;
        let n = arr.it;

        //console.log('iteraciones 1->',n);
        
        //calculate the color depending on the number of iterations
        bright =color(map(n, 0, iteraciones, 0, 255),0,0);
        
        //if iterations = max iterations then is part of the set and is colored in black
        if(n==iteraciones){ bright=0;}
        //set the pixel
        set(x1,y1,color(bright));
        
    }
   //draw them all
   updatePixels();
}  

myWorker2.onmessage = function(e) {
    let arr=[];
    while(e.data.length>0){
        
        arr=e.data.pop();
        let n = arr.it;
        
        bright =color(map(n, 0, iteraciones, 0, 255),0,0);
        if(n==iteraciones){ bright=0;}
        set(arr.x,arr.y,color(bright));
       
    }
    updatePixels();
}

myWorker3.onmessage = function(e) {
    let arr=[];
    while(e.data.length>0){
        
        arr=e.data.pop();
        let n = arr.it;

        
        bright =color(map(n, 0, iteraciones, 0, 255),0,0);
        if(n==iteraciones){ bright=0;}
        set(arr.x,arr.y,color(bright));
        
    }
    updatePixels();
}

myWorker4.onmessage = function(e) {
    let arr=[];
    while(e.data.length>0){
        
        arr=e.data.pop();
        let n = arr.it;

        
        bright =color(map(n, 0, iteraciones, 0, 255),0,0);
        if(n==iteraciones){ bright=0;}
        set(arr.x,arr.y,color(bright));
       
    }
    updatePixels();
} 
/*
myWorker5.onmessage = function(e) {
    let arr=[];
    while(e.data.length>0){
        arr=e.data.pop();
        let x1 = arr[0];
        let y1 = arr[1];
        let n = arr[2];
        console.log('iteraciones 5->',n);
        bright =color(map(n, 0, iteraciones, 0, 255),0,0);
        if(n==iteraciones){ bright=0;}
        //console.log("-> ",x1," ",y1," ",n);
        set(x1,y1,color(bright));
    }
    updatePixels();
} 
myWorker6.onmessage = function(e) {
    let arr=[];
    while(e.data.length>0){
        arr=e.data.pop();
        let x1 = arr[0];
        let y1 = arr[1];
        let n = arr[2];
        console.log('iteraciones 6->',n);
        bright =color(map(n, 0, iteraciones, 0, 255),0,0);
        if(n==iteraciones){ bright=0;}
        //console.log("-> ",x1," ",y1," ",n);
        set(x1,y1,color(bright));
    }
    updatePixels();
}  
*/    
    
    
    
   
    

//when clicked on any position of the screen, the canvas will ajust to that pointer be the center and do a zoom
function mouseClicked() {
    
        print(mouseX+" "+mouseY);
        
        
            let nex = map(mouseX,0,width,mapMinX,mapMaxX);
            let ney = map(mouseY,0,height,mapMinY,mapMaxY);

            let dx= (mapMaxX-mapMinX)/ (0.01*width);
            let dy= (mapMaxY-mapMinY)/(0.01*height);

            mapMinX = nex -dx;
            mapMinY = ney -dy;

            mapMaxX = nex +dx;
            mapMaxY = ney +dy;
            //when the screen is adjusted the workers will receive data with the new region
            for(let i=0; i<workers.length;i++){
               workers[i].postMessage([mapMaxX,mapMaxY,mapMinX,mapMinY]);                
            }

        //then the main loop is called again

        //setTimeout(function(){
            loop();
       // }, 2000);
     
}
        


