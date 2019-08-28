/* Author: Lia de Belda
Korch SnowFlake with a recursive algorithm,
using P5 library for JavaScript
see also: https://en.wikipedia.org/wiki/Koch_snowflake
*/


let angle=60;
let w=500;
let h= 500;
let len=100;
let x=0,y=0,x1=len,y1=0;

index=0;

function setup(){
    angleMode(DEGREES);
    createCanvas(w,h);
    background(color(87,35,100));  
}
function draw(){
    //first curve
    translate(50,h/4);
    stroke(0);
    iterar(len);
    noLoop();
    //second curve
    translate(len,0);
    rotate(angle*2);
    iterar(len);
    noLoop();
    //third curve
    translate(len,0);
    rotate(angle*2);
    iterar(len);
    noLoop();  
}
function iterar(len){
    if(len>1){
      push();
      iterar(len/3);
      pop();

      //line(x,y,len,0) ;
      translate(len,0);
      rotate(-angle);
      push();
      
      iterar(len/3);
      pop();
      //line(x,y,len,0);
      translate(len,0);
      rotate(angle*2);
      push();
      iterar(len/3);
      pop();

      //line(x,y,len,0);
      translate(len,0);
      rotate(-angle);

      push();
      len/=3;
      iterar(len);
      pop();
  
    }
    else{
        stroke(color(0,255,0));
        line(x,y,len,0) ;
    }
}
