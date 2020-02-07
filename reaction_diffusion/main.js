let width=200;
let heigth=200;
let squareSize = 1;
let matrix = [];
let next =[];

//difussion Element A and B
let dA = 1.0;
let dB = 0.5;


//feed rate
let f=0.055;
//kill rate
let k=0.062;

/*
//feed rate
let f=0.0367;
//kill rate
let k=0.0649;
*/

class cell{
    
    constructor(A,B,x,y){
        //Values of chemicals A and B
        this.A=A;
        this.B=B;
        this.x=x;
        this.y=y;
        }
}
function setup(){
    createCanvas(width, heigth);
    for(let i=0; i<width; i+=squareSize){
        let aux=[];
        let aux2=[];
        for(let j=0; j<heigth; j+=squareSize){
            let c = new cell(1,0,i,j);
            aux.push(c);
            aux2.push(c);
        }
        matrix.push(aux);
        next.push(aux2);
    }
    
   
    for(let v=0; v<10; v++){
        for(let v_ = 0; v_<10; v_++){
            //matrix[(int)(matrix.length/2)+v][(int)(matrix.length/2)+v_].A = 0;
            matrix[(int)(matrix.length/2)+v][(int)(matrix.length/2)+v_].B = 1;        
        }
    }
    
}

function getLaplaceA(i,j){
    let laplaceA =
        (matrix[i-1][j-1].A *0.05) +
        (matrix[i][j-1].A *0.2) +
        (matrix[i+1][j-1].A *0.05) +
        (matrix[i-1][j].A *0.2) +
        (matrix[i+1][j].A *0.2) +
        (matrix[i-1][j+1].A *0.05) +
        (matrix[i][j+1].A *0.2) +
        (matrix[i+1][j+1].A *0.05) -matrix[i][j].A
    ;
    return laplaceA;
}
function getLaplaceB(i,j){
    let laplaceB =
        (matrix[i-1][j-1].B *0.05) +
        (matrix[i][j-1].B *0.2) +
        (matrix[i+1][j-1].B *0.05) +
        (matrix[i-1][j].B *0.2) +
        (matrix[i+1][j].B *0.2) +
        (matrix[i-1][j+1].B *0.05) +
        (matrix[i][j+1].B *0.2) +
        (matrix[i+1][j+1].B *0.05) -matrix[i][j].B
    ;
    return laplaceB;
}

function draw(){
    background(42);
    
    for(let i=1;i<matrix.length-1;i++){
        for(let j=1;j<matrix[i].length-1;j++){
            
            let c_ = matrix[i][j];
            let a = c_.A;
            let b = c_.B;

            let colorFromChemical = floor((a-b)*255);
            colorFromChemical = constrain(colorFromChemical, 0, 255);
            stroke(colorFromChemical,colorFromChemical,colorFromChemical,255);
            fill(colorFromChemical,colorFromChemical,colorFromChemical,255);
            
            /*rect(c_.x, 
                c_.y, 
                squareSize, 
                squareSize
            );*/

            set(i, j, colorFromChemical);

            //print(ns_);
            let lapA = getLaplaceA(i,j);
            let lapB = getLaplaceB(i,j);
            
            next[i][j].A= a + ( (dA * lapA) - (a*b*b) + f*(1-a) );
            next[i][j].B= b + ( (dB * lapB) + (a*b*b) - ((k+f) * b) );

            next[i][j].A = constrain(next[i][j].A, 0, 1);
            next[i][j].B = constrain(next[i][j].B, 0, 1);
           
            //print(c_);
        }
       
        
    }/*
    for(let e=0; e<matrix.length; e++){
        for(let r=0; r<matrix[e].length; r++){
            
            let colorFromChemical = floor((matrix[e][r].A-matrix[e][r].B)*255);
            colorFromChemical = constrain(colorFromChemical, 0, 255);
            stroke(colorFromChemical,colorFromChemical,colorFromChemical,255);
            fill(colorFromChemical,colorFromChemical,colorFromChemical,255);
            rect(matrix[e][r].x, 
                matrix[e][r].y, 
                squareSize, 
                squareSize
            );
        }
    }*/
   
    updatePixels();
    doSwap();
    
}
function doSwap(){
    let temp = matrix;
    matrix = next;
    next = temp;
}
