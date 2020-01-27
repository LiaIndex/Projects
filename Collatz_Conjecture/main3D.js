/*
*  Example of Collatz conjecture
*  Author: Lia Belda Calvo
*  references: 
*    
*    https://en.wikipedia.org/wiki/Collatz_conjecture
*    https://www.youtube.com/watch?v=LqKpkdRRLZw
*      
*/

let quantity = 7;
//let angle = 0.1;
let matriz = [];
let omega =0;
let  slider;
let represent = [];
let red_ = 202;
let blue_ = 153;

function doCollatz(n){
  let aux = n;
  let result = [];
  result.push(aux);
  
  while( aux != 1 ){
    if(aux %2== 0){
      aux /= 2;
    }
    else{
      //canonic is 3n+1 but with /2 is more aesthetic
      aux =( aux * 3 +1 ) /2;
    }
    result.push(aux);
  }
 return result.reverse();
}

function mouseDragged() {
  background(40);
}

function setup() {
  
  createCanvas(800, 600,WEBGL);
  background(40);
  slider = createSlider(1,999,99);

  for ( let i = 9000; i<10000; i++){
    matriz.push(doCollatz(i));
  }
  
  stroke(100,101,253);
}



function draw() {
  background(40);
  orbitControl();
  translate(1, width*0.25,0);
  omega = slider.value();
  
  let sw = true;
 
  for(let i=matriz.length-omega; i<matriz.length; i++){
    push();
    stroke(red_-i%100,0,blue_+i%100);
    for(let j=0; j<matriz[i].length; j++){
      //MAGIC ANGLES
      if(matriz[i][j] %2 == 0){
        rotateX( 0.25-(0.0002*j));
        rotateY( 0.25-(0.0002*j));
      }
      else{
       rotateX( -0.24+(0.00025*j) );
       rotateY( -0.24+(0.00025*j) );
      }
      cylinder(1,quantity);
      translate( 0, -quantity,0);
    }
    pop();
    
    
  }
 
}
