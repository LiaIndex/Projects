


let width = 400;
let height = 400;

let radio =width/4;
let toplot = [];


let circulos = 3;

let angulos = [];
let centers = [];
let radios = [];
let frecuencias = [197,199,7];
let dt=1;

function setup() {
 createCanvas(width, height);
 for(let i=1; i<=circulos; i++){
    angulos.push(0.0);
    radios.push( radio / (i+1) );
  }
  //frecuencias = getNprimes(circulos).reverse();
  print(frecuencias);
  
}

function draw() {
  
  background(220);
  stroke(0);
  noFill();
  
  //original circle
  translate(width/2,height/2);
  circle(0,0,radio);
  
  for(let k=0; k<circulos; k++){
    
    
    let radioi = ( radio / Math.pow(2,(k+1)) );
    let freqi = frecuencias[k];
    if(k%2==0){
      angulos[k] += (PI / 1000 * dt);
    }
    else{
      angulos[k] -= (PI / 1000 * dt);
    }
    //nuevo centro para el siguiente orbital
    let xi = cos(angulos[k] * freqi) * radioi;
    let yi = sin(angulos[k] * freqi) * radioi;
    
    
     
    if(k>0 ){
      xi += centers[k-1].x ;
      yi += centers[k-1].y ;
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
