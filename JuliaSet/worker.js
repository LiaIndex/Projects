
//max iterations
let iterac=1200;
let w=1000;
let h=1000;

//imaginary component
let b;
//real and imagininary components squared
let aa,bb;
//real and imag. component of the complex number to iterate
let ca;
let cb;
//iterations
let n
//auxiliar coordinates variable s
let x1=0,y1;
//array to return
let fila=[];
//locked ? wait:calculate
let libre = true;
//boundaries
var mapMaxX2=2;
var mapMaxY2=2;
var mapMinX2=-2;
var mapMinY2=-2


let l= (mapMaxX2-mapMinX2)/w;

runing = function(){
    postMessage(libre);
}



onmessage = function(e) {
        
        //if e is an array, then it is a config message from main to set the canvas and turn the worker free for new tasks
        if(Array.isArray(e.data)){
           // console.log(e.data);
           libre=false;
            mapMaxX2=e.data[0];
            mapMaxY2=e.data[1];
            mapMinX2=e.data[2];
            mapMinY2=e.data[3];
            l= (mapMaxX2-mapMinX2)/w;
            libre=true;
            
        }
        //if is not an array then is a y coordinate to calculate
        else{
            //lock the worker and
            //in order to increase performance, the real component is deduced out of the x position of the pixel
            libre=false;
            let a=mapMinX2;
            
            //received data from main
            let y1 = e.data;
            //calculate imaginary component from the y position of the pixel
            b=map1(y1,0,h,mapMinY2,mapMaxY2);
            
            //iterate the width of the screen
            while(x1<w){
                
                //calculate the real component from the x coordinate
                a=map1(x1,0,w,mapMinX2,mapMaxX2);
                //get number of iterations of number z
                n=itera(a,b);
                

                //push into the vector "fila" (wich is going to return all the row to main) the result, x and y coordinates to the screen and number of iterations 
                fila.push({
                    x: x1,
                    y: y1,
                    it: n
                });
                
                x1++;
                //when finish the row, reset real component
                if(a>=mapMaxX2)a=mapMinX2;

            }
            //return data to main and reset the other parameters
            postMessage(fila);
            fila=[];

            x1=0;
            libre=true;
      
        }
}
//f(z)=z^2+c    on z is the actual number to iterate and c is a complex number constant
function itera(a,b){
    ca = -0.8;
    cb = 0.156;
    let n1=0;
    while (n1<iterac){
            
        aa = a * a-b * b;
        bb = 2  * a * b;
    
         a= aa+ca;
         b= bb +cb;
    
         if(((a*a)+(b*b))>=4){
             break;
         }
    
         n1++;
    }
        
    return n1;
}

function map1 (value, istart, istop,  ostart, ostop) {
return ostart + (ostop - ostart) * ((value - istart) / (istop - istart));
}
