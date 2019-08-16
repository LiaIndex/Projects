/*let AX=360;
let AY=300;

let BX=-520;
let BY=200;

let CX = 520;
let CY = 200;*/
let AX=0;
let AY=-279;

let BX=-170;
let BY=0;

let CX=170;
let CY =0;

let pX;
let pY;

function setup(){
    

    // Sets the screen to be 720 pixels wide and 400 pixels high
    createCanvas(720, 400);
    background(0);
    noSmooth();

    translate(320,300);
    stroke(255);
    frameRate(30);
    point(AX, AY);
    point(BX, BY);
    point(CX, CY);
    
    pX=AX;
    pY=BY;
/*
    for(let i=0; i<1000000; i++){
        draw();
        
    }*/
}

function draw(){
  translate(320,300);
    let vertexSelected = aleatorio(1,3);
    

    switch(vertexSelected) {
        case 1:
          // 
          pX=(pX+AX)/2;
          pY=(pY+AY)/2;
          point(pX,pY);
          break;
        case 2:
          // code block
          pX=(pX+BX)/2;
          pY=(pY+BY)/2;
          point(pX,pY);
          break;
        case 3:
            pX=(pX+CX)/2;
            pY=(pY+CY)/2;
            point(pX,pY);
        
        break;

        default:
          // code block
      }
}
function aleatorio(minimo,maximo){
    return Math.floor(Math.random() * ((maximo+1)-minimo)+minimo);
  }