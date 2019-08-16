//let currentangle=0;
let angle=60;
let w=2000;
let h= 2000;
let len=300;
let x=0,y=0,x1=len,y1=0;
//let iterations = 6;
//let chain='';
index=0;

function setup(){
    angleMode(DEGREES);
    createCanvas(w,h);
    background(color(87,35,100));
    
    /*
    let axiom = 'F++F++F';
    let rule='F-F++F-F';
    
    for(let i=0; i<iterations;i++){
        for(let x=0; x<axiom.length; x++){
            if(axiom.charAt(x)=='F'){
                chain+=rule;
            }
            else if(axiom.charAt(x)=='+' ||  axiom.charAt(x)=='-') chain+=axiom.charAt(x);
            
        }
    }
    print(chain);
    */
   
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

    /*
    
    drawO(chain[index]);
    
    index++;
    if(index>chain.length-1) index =0;
    */
  
    
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
}/*
function drawO(k){
    
    stroke(0);
    
    if(k=='F'){
        
            x1 = x + len*cos(radians(currentangle));
            y1 = y + len*sin(radians(currentangle));
            line(x, y, x1, y1);
            
      } else if (k == '+') {
        rotate(angle); // turn left
      } else if (k == '-') {
        rotate(-angle); // turn right
      }
      x=x1;
      y=y1;
      
    
}*/