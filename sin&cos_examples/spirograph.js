
 
let width = 400;
let height = 400;

let radio =width/4;
let toplot = [];


let circulos = 2;

let angulos = [];
let centers = [];
let radios = [];
let frecuencias = [/*89,149,163,173,*/197,199];
let dt=/*1/circulos*/1;

function setup() {
 createCanvas(width, height);
 for(let i=1; i<=circulos; i++){
    angulos.push(0.0);
    radios.push( radio / (i+1) );
  }
  //frecuencias = getNprimes(circulos);
}

function draw() {
  
  background(220);
  //rotate(PI/2);
  
  stroke(0);
  noFill();
  
  //original circle
  translate(width/2,height/2);
  circle(0,0,radio);
  
  for(let k=0; k<circulos; k++){
    
    
    //let radioi = ( radio / ( 2*(k+1) ) );
    let radioi = radios[k];
    let freqi = frecuencias[k];
    angulos[k] += (PI / 1000 * dt)   ;
    
    //nuevo centro para el siguiente orbital
    let xi = cos(angulos[k] * freqi) * radioi;
    let yi = sin(angulos[k] * freqi) * radioi;
    
    
     
    if(k>0 ){
      xi += centers[k-1].x;
      yi += centers[k-1].y;
      
    }
    
    circle(xi,yi,radioi);
    centers[k] = {x:xi, y:yi};
    
    
    
    if(k==circulos-1){
      toplot.push({x:xi,y:yi});
      //console.log(xi,yi);
    }
    
  }
  
  stroke(color(250,0,0));
  for(let i=0; i<toplot.length; i++){
    ellipse(toplot[i].x,toplot[i].y,2,2);
  }
  
  /*
  circle(0,0,radio);
  
  //x and y position of the orbital's center
  let x1 = cos(angulo1) * radio/2;
  let y1 = sin(angulo1) * radio/2;
  circle(x1,y1,radio/2);
  
  //add angle
  angulo1 += PI/500;
  
  
  //x and y of the second orbital
  
  let x2 = ( cos(angulo2) * radio/4 ) + x1;
  let y2 = ( sin(angulo2) * radio/4 ) + y1;
  
  circle(x2,y2,radio/4);
  
  //add to the 2nd angle
  angulo2 += PI/250;
  
  //plot trayectory
  let x_ = ( cos(angulo3) * radio/8) + x2;
  let y_ = ( sin(angulo3) * radio/8) + y2;
  
  
  toplot.push({x:x_,y:y_});
  angulo3 += PI/125;
  
  if(angulo1 >= 360) angulo1=0;
  if(angulo2 >= 360) angulo2=0;
  if(angulo3 >= 360) angulo3=0;
  
  stroke(color(250,0,0));
  for(let i=0; i<toplot.length; i++){
    point(toplot[i].x,toplot[i].y);
  }*/
}
function getNprimes(n){
  const arr = [];
  let i = 2

  while (arr.length < n) {
    if (isPrime(i)) {
      arr.push(i)
    }
    i++
  } 
  return arr;

  /*
  * @param n (integer)
  * @return Boolean
  *
  */
  function isPrime(n) {

    if ( n < 2 ) {
      return false
    }

    for ( let i = 2; i <= Math.sqrt(n); i++ ) {
      if ( n % i === 0 ) {
          return false;
      } 
    }
    return true
  }

}
