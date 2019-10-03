/*Title: Flow Field with Perlin Noise Cosine Interpolation
Author Lia de Belda

See: 
https://en.wikipedia.org/wiki/Perlin_noise
https://wiki.freepascal.org/Perlin_Noise
http://www.arendpeter.com/Perlin_Noise.html
*/




let width = 1080;
let height = 1080;
let vectors = [];
let vectors_ = [];

//number of boxes = denominator
let offsetX = width/5;
let offsetY = height/5;


let prt ;
let particles = [];
let debugMode = false;
let rainbow_mode = false;
let rmcolor

function setup(){
    //Activate Debug
    //debugMode=true;
    
    if(rainbow_mode){colorMode(HSB);}

    background(255);
    prt = new Particle();
    createCanvas(width, height);

    //set the array of vectors
    resArr();
    for(let i=0; i<500; i++){
        let pt = new Particle(
            createVector(
                parseInt(random(width)), 
                parseInt(random(height))
                )
            );
        particles.push(pt);
    }

    //initialize noise vectors
    getNoise();
}


class Particle {
    constructor(position) {
        this.acceleration = createVector(0, 0.10);
        this.velocity = createVector(random(-1, 1), random(-1, 1));
        this.position = position;
        this.prev = this.position;
        this.maxSpeed = 1;
        //for HSB color
        this.h_=0;
    }
    run() {
        this.update();
        this.display();
    }
    // Method to update position
    update() {
        if(debugMode){
            console.log("Velocity: "+ this.velocity + "\n",
                        "acceleration: "+this.acceleration + "\n",
                        "position : "+this.position 
            );
        }
        this.velocity.add(this.acceleration);
        this.prev = this.position;
        this.position.add(this.velocity);
        this.velocity.limit(1.15);
        this.h_++;
        if(this.h_>360)this.h_=0;
        if(this.position.x >= width){this.position.x = 1;}
        if(this.position.x <= 0){this.position.x = width-1;}
        if(this.position.y >= height){this.position.y = 1;}
        if(this.position.y <= 0){this.position.y = height-1;}
    }
    // Method to update position
    addAc(position_x,position_y) {
        
        this.acceleration.x +=  position_x;
        this.acceleration.y +=  position_y;
        this.acceleration.limit(1.15);   
    }

    // Method to display
    display() {
        
        if(rainbow_mode){stroke(this.h_,360,360,1)}
        else stroke(0,20);
        strokeWeight(1);
        fill(0);
        if(debugMode){
            ellipse(this.position.x, this.position.y, 1, 1);
        }
        line(
            this.position.x, 
            this.position.y, 
            this.position.x+this.velocity.x*5,
            this.position.y+ this.velocity.y*5 
        );
    }
}



  

  


function getNoise(){

    let xPos;
    let yPos;
    let aux = [];
    vectors_=[];
    
    
    for(let w=0; w<width; w+=(offsetX/16)){
        
        //x position on the vectors matrix
        xPos =parseInt(w/(width/(vectors.length-1)));
        //position from 0 to 1 on x
        let mapedX = map(
            w%(width/(vectors.length-1)),
            0,
            width/(vectors.length-1),
            0,1
        );

        for(let h=0; h<height; h+=(offsetY/16)){
             
            //y position on the vectors matrix
            yPos =parseInt(h/(height/(vectors[xPos].length-1)));
            
            //relative vectors to the pixel
            let vec1 = vectors[yPos+1][xPos];
            let vec2 = vectors[yPos][xPos];
            let vec3 = vectors[yPos+1][xPos+1];
            let vec4 = vectors[yPos][xPos+1];
            
            //position from 0 to 1 on y
            let mapedY = map(
                h%(height/(vectors[xPos].length-1)), 
                0, 
                height/(vectors[xPos].length-1), 
               1,0
            );
            //distance vectors
            let dist1 = createVector(mapedX, mapedY);
            let dist2 = createVector(mapedX, mapedY-1);
            let dist3 = createVector(mapedX-1, mapedY);
            let dist4 = createVector(mapedX-1, mapedY-1);
            //dot product relative vectors and distance vector
            let f1 = p5.Vector.dot(vec1, dist1);
            let f2 = p5.Vector.dot(vec2, dist2);
            let f3 = p5.Vector.dot(vec3, dist3);
            //console.log(xPos,yPos);
            let f4 = p5.Vector.dot(vec4, dist4);
            
            
            //cos interpolation
            let v1 = (1-cos(mapedX*PI))/2;
            let v2= (f1*(1-v1)+f3*v1);
            let v4= (f2*(1-v1)+f4*v1);

            v1 = (1-cos(mapedY*PI))/2;
            v2= (v2*(1-v1)+v4*v1);

            //smoth
            v2 = map(v2, -1, 1, 0, 1);
            v2 = 6*pow(v2,5)-15*pow(v2,4)+10*pow(v2,3);
             
            //get vector from noise
            let ang = map(v2, 0, 1, 0, 2*PI);
            vectorcito = p5.Vector.fromAngle(ang);
            aux.push(vectorcito);
            
           
            stroke(0,200);
            
            if(debugMode){
                fill(255,0,0);
                //----Draw a point of the flow field vectors----
                ellipse(w,h,10,10);
                //----Draw the direction of that vectors--------
                line(w,h,w+vectorcito.x*25,h+vectorcito.y*25);
            }
        }
        vectors_.push(aux);
        aux = [];
    }
    
    
}

let q = 1;
function draw(){
    
    if(debugMode){background(255);}
    if(rainbow_mode)colorMode(HSB);
    for(let i=0; i<particles.length; i++){
       //X and Y position on the matrix of noise vectors
       let ofX =  parseInt(particles[i].position.x/(width/(vectors_.length-1)));
       let ofY =  parseInt(particles[i].position.y/(height/(vectors_[ofX].length-1)));
       //get the noise vector correspondent to the position of the particle
       let v =vectors_[ofX][ofY];
       
       particles[i].addAc(v.x, v.y);
       particles[i].run();
    }
    //update reference and noise vectors 50% of times
    if(q % 3 == 0){
        resArr2();
        getNoise();
        //q = 1;
    }
    if(q == 10){
        //resArr();
        //getNoise();
        q = 1;
    }
    
    q++;
    //noLoop();
}

//initialize, reference vectors
function resArr(){
    vectors=[];
    for(let i=0; i<width; i+=offsetX){
        let aux = []; 
        for(let j=0; j<height; j+=offsetY){
            let p = createVector(
                random(-1, 1),
                random(-1, 1)
            ).normalize();
            aux.push(p);  
        }
        vectors.push(aux);
    }
}
//modify reference vectors
function resArr2(){
    for(let i=0; i<vectors.length; i++){
        for(let j=0; j<vectors[i].length; j++){
            vectors[i][j].rotate(random(0, PI/100));
        }
    }
}

function mouseClicked(){
    if(!rainbow_mode){
        background(0);
        rainbow_mode = true;
    }
    else{
        background(255);
        colorMode(RGB);
        stroke(0,70);
        rainbow_mode=false;
    }
}
