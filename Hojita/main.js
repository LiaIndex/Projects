let x=0;
let y=0;

function setup(){
    createCanvas(1000,1000);
    
    draw();
}

function draw(){
    translate(500,500);
    let r = aleatorio(1,100);
    stroke(0);
    print(r);
    let auxX = x;
    let auxY = y;
    
        if(r==1){
            //print("estoy en la funcion 1 opcion");
            funcion1(auxY);
            print("caso  1 x vale: ",x," e y vale: "+y);
            set(map(x, -2.5, 3, 0, 1000), map(y, 0, 10, 0, 1000),color(0));
            
        }
        else if(r>6 && r<15){
            //print("estoy en la funcion 2 opcion");
            funcion3(auxX,auxY);
            print("caso  2 x vale: ",x," e y vale: "+y);
            set(map(x, -2.5, 3, 0, 1000), map(y, 0, 10, 0, 1000),color(0));
        }
        else if(r>=15 && r<=23) {
            //print("estoy en la funcion 3 opcion");
            funcion4(auxX,auxY);
            print("caso  3 x vale: ",x," e y vale: "+y);
            set(map(x, -2.5, 3, 0, 1000), map(y, 0, 10, 0, 1000),color(0));
        }
        else if(r>23 || (r<6 && r>1)){
            //print("estoy en la funcion 4  opcion");
            funcion2(auxX,auxY);
            print("caso  4 x vale: ",x," e y vale: "+y);
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