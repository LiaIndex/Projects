/*
*  Example of Collatz conjecture
*  Author: Lia Belda Calvo
*  references: 
*    
*    https://en.wikipedia.org/wiki/Collatz_conjecture
*    https://www.youtube.com/watch?v=LqKpkdRRLZw
*      
*/

let quantity = 4;
let angle = 0.1;
let matriz = [];
let omega =0;
let  slider;

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

function setup() {
  createCanvas(800, 800,WEBGL);
  background(40);
  for ( let i = 20000; i<30000; i++){
    matriz.push(doCollatz(i));
  }
  slider = createSlider(1,250,99);
}
function mouseDragged() {
  background(40);
}
function waitfor(){
  let aux = matriz.length;
  for ( let i = aux; i<aux+100; i++){
    matriz.push(doCollatz(i));
  }
}
function draw() {
  background(40);
  omega = slider.value();
  orbitControl();
  translate(width*0.1, width*0.4,0);
  rotateY(millis() / 1000);
  /*rotateY(millis() / 1000);*/
  let sw = true;
  
  for(let i=matriz.length-omega; i<matriz.length; i++){
    if(sw){
      stroke(255,0,90,10);
      sw = false;
    }
    else{
      stroke(28,142,255,10);
      sw = true;
    }
      
    push();
    for(let j=0; j<matriz[i].length; j++){
      //MAGIC ANGLES
      if(matriz[i][j] %2 == 0){
        rotateX( 0.20-(0.0002*j));
        rotateY( 0.20-(0.0002*j));
      }
      else{
       rotateX( -0.19+(0.00025*j) );
       rotateY( -0.19+(0.00025*j) );
      }
      
      //line( 0, 0, 0, 0, -quantity ,0);
      sphere(quantity,1,1);
      translate( 0, -quantity,0);
    }
    pop();
  }
  
  if(matriz.length <=5000){setTimeout(waitfor,3000);}
  
}
