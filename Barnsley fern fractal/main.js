/*
Author: Lia de Belda
Barnsley fern fractal.
see also : https://en.wikipedia.org/wiki/Barnsley_fern
Using P5 Library for JavaScript
*/

let x=0;
let y=0;

//width and height of the canvas
let w = 750;
let h = 750;

function setup(){
    createCanvas(w,h);
    draw();
}

function draw(){
    //translate(w/2,h/2);
    
    for(let i=0; i<150; i++){
      //set the probability of the function to follow
      let r = myRnd(1,100);
      stroke(0);
      strokeWeight(2);
      
      let auxX = x;
      let auxY = y;
    
        //1%
        if(r==1){
            f1(auxY);
            point(map(x, -2.5, 3, 0, w), map(y, 0, 10, 0, h));
        }
        //8%
        else if(r>6 && r<15){
            f3(auxX,auxY);
            point(map(x, -2.5, 3, 0, w), map(y, 0, 10, 0, h));
        }
        //9%
        else if(r>=15 && r<=23) {
            f4(auxX,auxY);
            point(map(x, -2.5, 3, 0, w), map(y, 0, 10, 0, h));
        }
        //82%
        else if(r>23 || (r<6 && r>1)){
            f2(auxX,auxY);
            point(map(x, -2.5, 3, 0, w), map(y, 0, 10, 0, h));
        }
        //updatePixels();
    }
}

function f1(b){
    x=0;
    y=0.16*b;
}
function f2(a,b){
    x=0.85*a+0.04*b;
    y=-0.04*a+0.85*b+1.6;
}
function f3(a,b){
    x=0.2*a-0.26*b;
    y=0.23*a+0.22*b+1.6;
}
function f4(a,b){
    x=-0.15*a+0.28*b;
    y=0.26*a+0.24*b+0.44;
}

function myRnd(minimo,maximo){
    return Math.floor(Math.random() * ((maximo+1)-minimo)+minimo);
  }
