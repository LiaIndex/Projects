/*
Author: Lia de Belda
Using P5 Library for JavaScript
*/

let x=0;
let y=0;

//width and height of the canvas
let w = 1000;
let h = 1000;

function setup(){
    createCanvas(w,h);
    draw();
}

function draw(){
    translate(w/2,h/2);
    
    //set the probability of the function to follow
    let r = aleatorio(1,100);
    stroke(0);
    //print(r);
    let auxX = x;
    let auxY = y;
    
        //1%
        if(r==1){
            
            funcion1(auxY);
            set(map(x, -2.5, 3, 0, 1000), map(y, 0, 10, 0, 1000),color(0));
            
        }
        //8%
        else if(r>6 && r<15){
            
            funcion3(auxX,auxY);
            set(map(x, -2.5, 3, 0, 1000), map(y, 0, 10, 0, 1000),color(0));
        }
        //9%
        else if(r>=15 && r<=23) {
            
            funcion4(auxX,auxY);
            set(map(x, -2.5, 3, 0, 1000), map(y, 0, 10, 0, 1000),color(0));
        }
        //82%
        else if(r>23 || (r<6 && r>1)){
            
            funcion2(auxX,auxY);
            set(map(x, -2.5, 3, 0, 1000), map(y, 0, 10, 0, 1000),color(0));
        }
        updatePixels();
     
}

function funcion1(b){
    x=0;
    y=0.16*b;
}
function funcion2(a,b){
    x=0.85*a+0.04*b;
    y=-0.04*a+0.85*b+1.6;
}
function funcion3(a,b){
    x=0.2*a-0.26*b;
    y=0.23*a+0.22*b+1.6;
}
function funcion4(a,b){
    x=-0.15*a+0.28*b;
    y=0.26*a+0.24*b+0.44;
}

function aleatorio(minimo,maximo){
    return Math.floor(Math.random() * ((maximo+1)-minimo)+minimo);
  }
