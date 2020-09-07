//Example of sin and cos with a spiragraph
//Author: Lia Belda
//References: benice-equation.blogspot.com


let width = 600;
let height = 600;
let base = 2;

let config1 = false;
let config2 = false;
let config3 = false;

let button1;
let button2;
let button3

let radio =width/2;
let toplot = [];

//number of orbitals
let circulos = 
    2;


let angulos = [];
let centers = [];
let radios = [];


let frecuencias = [197,199];
let dt=1/5;

function setup() {
 createCanvas(width, height);
  fullscreen(true);
  button1 = createButton('snow');
  button2 = createButton('fractal');
  button3 = createButton('primes');

  button1.position(0,0);
  button2.position(0,20);
  button3.position(0,40);
  
  button1.mousePressed(changeConfig1);
  button2.mousePressed(changeConfig2);
  button3.mousePressed(changeConfig3);
  
 
  for (let j = 0; j<circulos; j++){
    angulos.push(0.0);
    //interesting: power of 2,3
     
    radios[j] = ( radio / Math.pow(2,(j+1)) );
    //frecuencias[j] = Math.pow(5,j-1);
    
  }
   
  /*
  3 consecutive primes also generate interesting patterns
  frecuencias =  [5,7,11];
  circulos = 3;
  */
      
  //proporcional frequencies
  //frecuencias = getNprimes(circulos).reverse();
  //print(frecuencias);
  
}

function changeConfig1(){
  background(color(26,26,26));
  circulos = 10;
  dt=1/50;
  config1 = true;
  config2 = false;
  angulos = [];
  toplot=[];
  
  for (let j = 0; j<circulos; j++){
    angulos.push(0.0);
    //interesting: power of 2,3
    //remove /1.5 in order to draw it in the orbit, /1.5 for inner orbit
    radios[j] = ( (radio/1.5) / Math.pow(2,(j+1)) ) ;
    frecuencias[j] = Math.pow(4,j+1);
   }
}

function changeConfig2(){
  background(color(26,26,26));
  circulos = 10;
  dt=1/5;
  base = 2 ;
  config1 = false;
  config2 = true;
  config3 = false;
  angulos = [];
  toplot=[];
  
  for (let j = 0; j<circulos; j++){
    angulos.push(0.0);
    //interesting: power of 2,3
    radios[j] = ( radio / Math.pow(3,(j+1)) );
    frecuencias[j] = Math.pow(base,j+1);
  }
}

function changeConfig3(){
  background(color(26,26,26));
  circulos = 2;
  
  config1 = false;
  config2 = false;
  config3 = true;
  angulos = [];
  toplot=[];
  
  

  frecuencias = [197,199];
  dt=1/5;

  
  for (let j = 0; j<circulos; j++){
    angulos.push(0.0);
    //interesting: power of 2,3
     
    radios[j] = ( radio / Math.pow(2,(j+1)) );
    //frecuencias[j] = Math.pow(5,j-1);
    
  }}

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
  
  if( angulos[0] <= ( -PI ) && config2){
    base++;
    dt /= 2;
    for (let j = 0; j<circulos; j++){
      angulos[j] = 0.0;
      frecuencias[j] = Math.pow(base,j+1);
    }
    background(color(26,26,26));
    toplot = [];
  }
  
  stroke(color(250,0,0));
  for(let i=0; i<toplot.length; i++){
    stroke(248,93,93);
    if (i >0){
      line(toplot[i].x, toplot[i].y, toplot[i-1].x, toplot[i-1].y);
    }
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
