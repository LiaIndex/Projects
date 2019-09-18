/*
Title : Lissajous_Figures
Author: Lia Belda Calvo
example of Lissajous_Figures in P5
*/

let nCircles = 7;
let N = 9;
let r;
let alp=0;
let alp2=0;

let array_centersX = [];
let array_centersY = [];
let colors = 
    [{R: 255,G: 0, B: 0}, //red
     {R:253,G:143, B:27}, //orange
     {R:240,G:240, B:0}, //yellow
     {R:38,G:184, B:62}, //green
     {R:0,G:161, B:240}, //blue
     {R:29,G: 11, B:230}, //edgy blue
     {R:255,G:0, B:240}  //purple
    ];

function setup() {
  
  createCanvas(600, 600);
  //radius
  r = width / N;
  for(let i=r*2; i<width; i+=r){
    circle(i, 50, r);
    array_centersX.push({x: i, y:50});
  }
  
  for(let i=r*2; i<height; i+=r){
    circle(50, i, r);
    array_centersY.push({x: 50, y:i});    
  }
  
}
//variable to reset the screen and restart the loop
let justOne = 1;


function draw() {
  
  //Setting up canvas block
  if(justOne==1){
    background(244,244,244);
    justOne=0;
  }
  
  fill(244,244,244);
  noStroke();
  rect(0, 0, width, 100);
  rect(0, 0, 100, height);
  noFill();
  stroke(1);
  //end setup--------------
  
  
  //color of the x an y orbit circles
  let colorX;
  let colorY;
  
  //draw the X and Y circles
  for(let i=r*2; i<width; i+=r){
    circle(i, 50, r);   
    circle(50, i, r);
  }
  
  
  stroke(0,0,0,150);
  
  //for X axis cicles
  for(let iterador = 0; iterador<array_centersX.length; iterador++){
    
    colorX = colors[iterador];
    //save state
    push();
    //get X and Y position of the center of the i circle of X axes
    let arr = array_centersX[iterador];
    //translate to that position
    translate(arr.x, arr.y);
    //calculate the x and y position of the orbital circle
    let i= cos(alp*(iterador+1))*r/2;
    let j= sin(alp*(iterador+1))*r/2;
    //get the r g b values
    let c11 = colorX.R;
    let c12 = colorX.G;
    let c13 = colorX.B;
    fill(c11,c12,c13);
    //orbital
    circle(i,j,r/10);
    alp+=PI/1000;
    if(alp==360) {alp = 0;}
    pop();
    //return state
    
    //for Y axis circles
    for(let iterador2 = 0; iterador2<array_centersX.length; iterador2++){
      colorY=colors[iterador2];
      push();
      let arr2 = array_centersY[iterador2];
    
      translate(arr2.x, arr2.y);
      let k= cos(alp2*(iterador2+1))*r/2;
      let l= sin(alp2*(iterador2+1))*r/2;
    
      let c21 = colorY.R;
      let c22 = colorY.G;
      let c23 = colorY.B;
      fill(c21,c22,c23);
      circle(k,l,iterador);
      strokeWeight(2);
    
    
      //add the colors
      let c31 = sqrt((c11*c11 + c21*c21)/2);
      let c32 = sqrt((c12*c12 + c22*c22)/2);
      let c33 = sqrt((c13*c13 + c23*c23)/2);
      
      stroke(c31,c32,c33, 150);
      point(k+(iterador*r)+4/3*r,j);
      //the second angle changes nCircles times slower bcs it changes nCircles times more
      alp2+=PI/7000;
      if(alp2==360) {alp2 = 0;}
      pop();
       
    }//2 for
   }//1 for
  
  
}

//reset canvas
function mouseClicked(){
  justOne=1;
}
