let width=1000;
let height=1000;
let iteraciones=1200;


/*version con workers añadir worker en index*/

var bright;


var mapMaxX=2;
var mapMaxY=2;
var mapMinX=-2;
var mapMinY=-2

let xZonaNula;
let yZonaNula=80;

let myWorker1 = new Worker("worker.js");
let myWorker2= new Worker("worker.js");
let myWorker3 = new Worker("worker.js");
let myWorker4 = new Worker("worker.js");
let workers = [myWorker1,myWorker2,myWorker3,myWorker4];
/*const myWorker5 = new Worker("worker.js");
const myWorker6 = new Worker("worker.js");*/

function setup(){
    
   
  createCanvas(width,height);
 /* input = createInput();
  input.position(20, 65);

  button = createButton('submit');
  button.position(input.x + input.width, 65);
  button.mouseClicked(greet);
  xZonaNula=input.x + input.width +button.x+button.width +10;  
  */
}
/*
function greet(){
    
    if(input.value!=''){
        print(input.value.parseInt);
        iteraciones=parseInt(input.value());
        input.value='';
        loop();
    } /*print("pene");*/
   
/*}*/



let y=0;







function draw(){
    //print("lol");
    // print("principio for");
    //for(var x = 0; x  < width; x++){
    
   
    /*
    fila2.push([y+1,mapMinX,mapMaxX,mapMinY,mapMaxY]);
    fila3.push([y+2,mapMinX,mapMaxX,mapMinY,mapMaxY]);
    fila4.push([y+3,mapMinX,mapMaxX,mapMinY,mapMaxY]);
    fila5.push([y+4,mapMinX,mapMaxX,mapMinY,mapMaxY]);
    fila6.push([y+5,mapMinX,mapMaxX,mapMinY,mapMaxY]);
    */

   
    //console.log("nepe");
    
    for(let i=0; i<workers.length;i++){
        if(workers[i].runing = function(e)  { e.data == true}){
            workers[i].postMessage(y+i);
        }
        else{print(workers[i].runing);}
    }
        //console.log("desde el padre: mando una fila x: ",x," y: ",y);
        
        
        
        /*
        myWorker1.postMessage(fila1);
        myWorker2.postMessage(fila2);
        myWorker3.postMessage(fila3);
        myWorker4.postMessage(fila4);*/
        /*myWorker5.postMessage(fila5);
        myWorker6.postMessage(fila6);*/

        /*
        /*fila5=[];
        fila6=[];*/

        
        
        
        
       
    if(y>=height){
        y=0;
        noLoop();
             
    }
    y+=4;
    //updatePixels();
    
    
    
}

myWorker1.onmessage = function(e) {
    let arr=[];
    while(e.data.length>0){
        arr=e.data.pop();
        let x1 = arr.x;
        let y1 = arr.y;
        let n = arr.it;

        //console.log('iteraciones 1->',n);
        
        bright =color(map(n, 0, iteraciones, 0, 255),0,0);
        if(n==iteraciones){ bright=0;}
        //console.log("-> ",x1," ",y1," ",n);
        set(x1,y1,color(bright));
        //updatePixels();
    }
   updatePixels();
}   /*
    for(let o=0; o<e.data.length; o++){
        let x1 = e.data[o][0];
        let y1 = e.data[o][1];
        let n = e.data[o][2];
        //console.log('iteraciones 1->',n);
        bright =color(map(n, 0, iteraciones, 0, 255),0,0);
        if(n==iteraciones){ bright=0;}
        //console.log("-> ",x1," ",y1," ",n);
        set(x1,y1,color(bright));
    }*/
    

myWorker2.onmessage = function(e) {
    let arr=[];
    while(e.data.length>0){
        
        arr=e.data.pop();
        let n = arr.it;

        //console.log('iteraciones 2->',n);
        
        bright =color(map(n, 0, iteraciones, 0, 255),0,0);
        if(n==iteraciones){ bright=0;}
        //console.log("-> ",x1," ",y1," ",n);
        set(arr.x,arr.y,color(bright));
        //updatePixels();
    }
    updatePixels();
}
myWorker3.onmessage = function(e) {
    let arr=[];
    while(e.data.length>0){
        
        arr=e.data.pop();
        let n = arr.it;

        //console.log('iteraciones 2->',n);
        
        bright =color(map(n, 0, iteraciones, 0, 255),0,0);
        if(n==iteraciones){ bright=0;}
        //console.log("-> ",x1," ",y1," ",n);
        set(arr.x,arr.y,color(bright));
        //updatePixels();
    }
    updatePixels();
}
myWorker4.onmessage = function(e) {
    let arr=[];
    while(e.data.length>0){
        
        arr=e.data.pop();
        let n = arr.it;

        //console.log('iteraciones 2->',n);
        
        bright =color(map(n, 0, iteraciones, 0, 255),0,0);
        if(n==iteraciones){ bright=0;}
        //console.log("-> ",x1," ",y1," ",n);
        set(arr.x,arr.y,color(bright));
       //updatePixels();
    }
    updatePixels();
} /*
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
    
    
    
   
    

    
function mouseClicked() {
    /* let xM = mouseX;
        let yM =  mouseY;*/
        print(mouseX+" "+mouseY);
        
        
            let nex = map(mouseX,0,width,mapMinX,mapMaxX);
            let ney = map(mouseY,0,height,mapMinY,mapMaxY);

            let dx= (mapMaxX-mapMinX)/ (0.01*width);
            let dy= (mapMaxY-mapMinY)/(0.01*height);

            mapMinX = nex -dx;
            mapMinY = ney -dy;

            mapMaxX = nex +dx;
            mapMaxY = ney +dy;
            
            for(let i=0; i<workers.length;i++){
               workers[i].postMessage([mapMaxX,mapMaxY,mapMinX,mapMinY]);
                
            }

        // print("X raton : "+nex+" y raton : "+ney);

        //setTimeout(function(){
            loop();
       // }, 2000);
            
        
        
        
        
}
        


