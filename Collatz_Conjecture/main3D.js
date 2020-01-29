/*
*  Example of Collatz conjecture
*  Author: Lia Belda Calvo
*  references: 
*    
*    https://en.wikipedia.org/wiki/Collatz_conjecture
*    https://www.youtube.com/watch?v=LqKpkdRRLZw
*      
*/

let quantity = 6;
let matriz = [];
let omega =0;
let  slider;
let red_ = 202;
let blue_ = 153;

/**
*  return an array containing the i angle of rotation 
*  correspondent to the i element of the Collatz path for the 
*  given number n.
*
*   n = 2; result = [ 0.20-(0.0002*0) ]
*   n = 3; result = [ 
*                    -0.19-(0.00025 * 0),
*                    -0.19-(0.00025 * 1),
*                     0.20-(0.0002  * 2),
*                     0.20-(0.0002  * 3),
*                     0.20-(0.0002  * 4)
*                   ]
**/
function doCollatz(n){
  let aux = n;
  let angle;
  let cont = 1;
  let result = [];
  let a1 = PI/13;
  let a2 = -PI/20;
  result.push( n%2 == 0 ? a1 : a2 );
  
  while( aux != 1 ){
    if(aux %2 == 0){
      aux /= 2;
      angle = a1;
    }
    else{
      //canonic is 3n+1 but with /2 is more aesthetic
      aux =( aux * 3 +1 ) /2;
      angle = a2;
    }
    result.push(angle);
    cont++;
  }
 return result.reverse();
}
function mouseDragged() {
  background(40);
}
function setup() {
  
  createCanvas(2400, 2400,WEBGL);
  background(40);
  slider = createSlider(1,7500,99);
  for ( let i = 1000; i<10000; i++){
    matriz.push(doCollatz(i));
  }
  rectMode(CENTER);
}
function draw() {
  
  background(40);
  orbitControl();
  noStroke();
  strokeWeight(1);
  directionalLight(250, 250, 250, 200, 0, 0);
  directionalLight(250, 250, 250, -200, 0, 0);

  //rotateY(-millis() / 1000);
  //rotateZ(millis() / 1000);
  
  omega = slider.value();
  scale(2);
 
  for(let i=matriz.length-omega; i<matriz.length; i++){
    push();
         fill(red_-i%100,0,blue_+i%100);
         for(let j=0; j<matriz[i].length; j++){
            rotateX(matriz[i][j]);
            rotateY(matriz[i][j]);
            box(5,quantity,3);
            translate( 0, -quantity,0);
          }
    pop();
  }
  
}
