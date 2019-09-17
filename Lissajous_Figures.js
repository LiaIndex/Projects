/*
Title : Lissajous_Figures
Author: Lia Belda Calvo
example of LisLissajous_Figures in P5
*/

let nCircles = 7;
let N = 9;
let r;
let alp=0;
let alp2=0;

let array_centersX = [];
let array_centersY = [];
function setup() {
  
  createCanvas(600, 600);
   r = width / N;
  for(let i=r*2; i<width; i+=r){
  
    circle(i, 50, r);
   
    array_centersX.push(
      {x: i, y:50}
    );
    
  }
  
  for(let i=r*2; i<height; i+=r){
  
    circle(50, i, r);
    array_centersY.push(
      {x: 50, y:i}
    );
    
  }
}

function draw() {
 // background(255);
  //translate(width/2, height/2);
  noFill();
  
  for(let i=r*2; i<width; i+=r){
    circle(i, 50, r);   
    circle(50, i, r);
  }
  
  //console.log(array_centersX);
  
  stroke(0,0,0,150);
  for(let iterador = 0; iterador<array_centersX.length; iterador++){
    push();
    let arr = array_centersX[iterador];
    
    translate(arr.x, arr.y);
    let i= cos(alp*(iterador+1))*r/2;
    let j= sin(alp*(iterador+1))*r/2;
    
    circle(i,j,r/10);
    alp+=PI/1000;
    if(alp==360) {alp = 0;}
    pop();
    
    for(let iterador2 = 0; iterador2<array_centersX.length; iterador2++){
    push();
    let arr2 = array_centersY[iterador2];
    
    translate(arr2.x, arr2.y);
    let k= cos(alp2*(iterador2+1))*r/2;
    let l= sin(alp2*(iterador2+1))*r/2;
    
    circle(k,l,iterador);
    strokeWeight(2);
    stroke(random(0,255),0,150);
    point(k+(iterador*r)+4/3*r,j);
    //point(i+(iterador*r)+r,l);
    alp2+=PI/7000;
    if(alp2==360) {alp2 = 0;}
    pop();
    /* 
    push();
    translate(width/2, height/2);
    
    scale(6);
    point(k,j);
    point(i,l);
      
    pop();*/
    
  }
  
  //noLoop();
}
}
