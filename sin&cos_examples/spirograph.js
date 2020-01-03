//Example of sin and cos with a spiragraph
//Author: Lia Belda
//References: benice-equation.blogspot.com


let width = 400;
let height = 400;

let radio =width/4;
let toplot = [];

//number of orbitals
let circulos = 7;

let angulos = [];
let centers = [];
let radios = [];


let frecuencias = [197,199,7];
let dt=1/circulos;

function setup() {
 createCanvas(width, height);
 
  for (let j = 0; j<circulos; j++){
    angulos.push(0.0);
    radios[j] = ( radio / Math.pow(2,(j+1)) );  
    frecuencias[j] = Math.pow(4,j+1);
  }
  //proporcional frequencies
  //frecuencias = getNprimes(circulos).reverse();
  //print(frecuencias);
  
}

function draw() {
  
  background(220);
  stroke(0);
  noFill();
  translate(width/2,height/2);
  
  //original circle
  circle(0,0,radio);
  
  for(let k=0; k<circulos; k++){
    
    //1,2,4,8,16....
    let radioi = radios[k];
    
    //frecuencias[k] for proporcional rates 
    //number of vertex = base +1
    let freqi = frecuencias[k] ;
                
    
    //angles changes
    if(k%2!=0){
      angulos[k] += (PI / 1000 * dt);
    }
    else{
      angulos[k] -= (PI / 1000 * dt);
    }
    //new center for the orbital
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
