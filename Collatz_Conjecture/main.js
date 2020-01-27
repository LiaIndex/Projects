/*
*  Example of Collatz conjecture
*  Author: Lia Belda Calvo
*  references: 
*    
*    https://en.wikipedia.org/wiki/Collatz_conjecture
*    https://www.youtube.com/watch?v=LqKpkdRRLZw
*      
*/

let quantity = 5;
let angle = 0.1;
let matriz = [];

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
  createCanvas(600, 600);
  background(40);
  for ( let i = 1; i<200; i++){
    matriz.push(doCollatz(i));
  }
  
}
function waitfor(){
  let aux = matriz.length;
  for ( let i = aux; i<aux+100; i++){
    matriz.push(doCollatz(i));
  }
}
function draw() {
  
  translate(width*0.5, width*0.9);
  let sw = true;
  
  for(let i=matriz.length-99; i<matriz.length; i++){
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
      
      if(matriz[i][j] %2 == 0){
        rotate( -angle );
      }
      else{
       rotate( angle );
      }
      
      line( 0, 0,  0, -quantity );
      translate( 0, -quantity);
    }
    pop();
  }
  setTimeout(waitfor,3000);
  
}
