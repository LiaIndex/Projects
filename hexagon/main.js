/*let AX=360;
let AY=300;

let BX=-520;
let BY=200;

let CX = 520;
let CY = 200;*/
let AX=1000;
let AY=1000;

let BX=500;
let BY=1866

let CX=1500;
let CY =1866;

let DX=2000;
let DY=1000;

let EX= 1500;
let EY= 134;

let FX= 500;
let FY= 134;

let GX= 0;
let GY = 1000;

let pX;
let pY;

function setup(){
    

    // Sets the screen to be 720 pixels wide and 400 pixels high
    createCanvas(2000,2000);
    background(0);
    noSmooth();

    
    stroke(255);
    frameRate(30);
    point(AX, AY);
    point(BX, BY);
    point(CX, CY);
    point(DX, DY);
    point(EX, EY);
    point(FX, FY);
    point(GX,GY);
    
    pX=AX;
    pY=BY;
/*
    for(let i=0; i<1000000; i++){
        draw();
        
    }*/
}

function draw(){
  translate(0,0);
    //orden de los triangulos en sentido contrario a las agujas del reloj
    
    let vertexSelected = 0;
    stroke(color(255,0,0));
    fill(color(140,0,0));
    for(let i=0; i<10000; i++){
        vertexSelected = aleatorio(1,3);
       
        switch(vertexSelected){
            case 1:
                pX=(pX+AX)/2;
                pY=(pY+AY)/2;
                ellipse(pX,pY,1,1);
            break;
            case 2:
                pX=(pX+BX)/2;
                pY=(pY+BY)/2;
                ellipse(pX,pY,1,1);
            break;
            case 3:
                pX=(pX+CX)/2;
                pY=(pY+CY)/2;
                ellipse(pX,pY,1,1);
            break;

        }
    }
    pX=CX;
    pY=CY;

    for(let i=0; i<10000; i++){
        vertexSelected = aleatorio(1,3);
       
        switch(vertexSelected){
            case 1:
                pX=(pX+AX)/2;
                pY=(pY+AY)/2;
                ellipse(pX,pY,1,1);
            break;
            case 2:
                pX=(pX+CX)/2;
                pY=(pY+CY)/2;
                ellipse(pX,pY,1,1);
            break;
            case 3:
                pX=(pX+DX)/2;
                pY=(pY+DY)/2;
                ellipse(pX,pY,1,1);
            break;

        }
    }
    pX=DX;
    pY=DY;

    for(let i=0; i<10000; i++){
        vertexSelected = aleatorio(1,3);
       
        switch(vertexSelected){
            case 1:
                pX=(pX+AX)/2;
                pY=(pY+AY)/2;
                ellipse(pX,pY,1,1);
            break;
            case 2:
                pX=(pX+DX)/2;
                pY=(pY+DY)/2;
                ellipse(pX,pY,1,1);
            break;
            case 3:
                pX=(pX+EX)/2;
                pY=(pY+EY)/2;
                ellipse(pX,pY,1,1);
            break;

        }
    }
    pX=EX;
    pY=EY;

    for(let i=0; i<10000; i++){
        vertexSelected = aleatorio(1,3);
       
        switch(vertexSelected){
            case 1:
                pX=(pX+AX)/2;
                pY=(pY+AY)/2;
                ellipse(pX,pY,1,1);
            break;
            case 2:
                pX=(pX+EX)/2;
                pY=(pY+EY)/2;
                ellipse(pX,pY,1,1);
            break;
            case 3:
                pX=(pX+FX)/2;
                pY=(pY+FY)/2;
                ellipse(pX,pY,1,1);
            break;

        }
    }
    pX=FX;
    pY=FY;

    for(let i=0; i<10000; i++){
        vertexSelected = aleatorio(1,3);
       
        switch(vertexSelected){
            case 1:
                pX=(pX+AX)/2;
                pY=(pY+AY)/2;
                ellipse(pX,pY,1,1);
            break;
            case 2:
                pX=(pX+FX)/2;
                pY=(pY+FY)/2;
                ellipse(pX,pY,1,1);
            break;
            case 3:
                pX=(pX+GX)/2;
                pY=(pY+GY)/2;
                ellipse(pX,pY,1,1);
            break;

        }
    }
    pX=GX;
    pY=GY;

    for(let i=0; i<10000; i++){
        vertexSelected = aleatorio(1,3);
       
        switch(vertexSelected){
            case 1:
                pX=(pX+AX)/2;
                pY=(pY+AY)/2;
                ellipse(pX,pY,1,1);
            break;
            case 2:
                pX=(pX+GX)/2;
                pY=(pY+GY)/2;
                ellipse(pX,pY,1,1);
            break;
            case 3:
                pX=(pX+BX)/2;
                pY=(pY+BY)/2;
                ellipse(pX,pY,1,1);
            break;

        }
    }
    pX=BX;
    pY=BY;


}
function aleatorio(minimo,maximo){
    return Math.floor(Math.random() * ((maximo+1)-minimo)+minimo);
  }
