
let angle=60;
let w=2000;
let h= 2000;
let len=300;
let x=0,y=0,x1=len,y1=0;

index=0;

function setup(){
    angleMode(DEGREES);
    createCanvas(w,h);
    background(color(87,35,100));  
}
function draw(){
    //primera curva
    translate(500,h/2);
    stroke(0);
    iterar(len);
    noLoop();
    //segunda curva
    translate(len,0);
    rotate(angle*2);
    iterar(len);
    noLoop();
    //tercera curva
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
       /* translate(len,0);
        rotate(angle*2);*/
    }
}
