//Example of sin and cos with a spiragraph
//Author: Lia Belda
//References: benice-equation.blogspot.com


let width = 800;
let height = 800;

let radio =width/2;
let toplot = [];

//number of orbitals
let circulos = 
    101;

let angulos = [];
let centers = [];
let radios = [];


let frecuencias = [97,31,17];
let dt=1/circulos;

function setup() {
 createCanvas(width, height);
 
  for (let j = 0; j<circulos; j++){
    angulos.push(0.0);
    
    //interesting: power of 2,3
    radios[j] = ( radio / Math.pow(2,(j+1)) );
    
    frecuencias[j] = Math.pow(4,j+1);
  }
  //proporcional frequencies
  //frecuencias = getNprimes(circulos).reverse();
  //print(frecuencias);
  
}

function draw() {
  
  background(color(26,26,26));
  stroke(255);
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
      angulos[k] += (PI / 200 * dt);
    }
    else{
      angulos[k] -= (PI / 200 * dt);
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
    stroke(248,93,93);
    //ellipse(toplot[i].x,toplot[i].y,2,2);
    if (i >0){
      line(toplot[i].x, toplot[i].y, toplot[i-1].x, toplot[i-1].y);
    }
   //if(i%3==0)toplot.splice(toplot.length/2,toplot.length);
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
