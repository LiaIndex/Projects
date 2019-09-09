/*Title: Perlin Noise Cosine Interpolation
Author Lia de Belda
example of Perlin algorithm in P5
See: 
https://en.wikipedia.org/wiki/Perlin_noise
https://wiki.freepascal.org/Perlin_Noise
http://www.arendpeter.com/Perlin_Noise.html
*/

let width = 1000;
let height = 1000;
let vectors = [];
let pg;
//number of boxes = denominator
let offset = width/10;

function setup(){
    
    createCanvas(width, height,WEBGL);
    
    //set the array of vectors
    resArr();
    
}

function draw(){
    //rotateZ(frameCount*0.02);
    rotateY(PI);
    rotateX(-PI/3);
    rotateZ(PI);
    translate(-width/2,-height/2);

    background(255);
    let xPos;
    let yPos;

    
    //rotateZ(frameCount*0.02);


    for(let w=0; w<width; w+=8){
        //x position on the vectors matrix
        xPos =parseInt(w/(width/(vectors.length-1)));
        //position from 0 to 1 on x
        let mapedX = map(
            w%(width/(vectors.length-1)),
            0,
            width/(vectors.length-1),
            0,1
        );
        for(let h=0; h<height; h+=8){
            //y position on the vectors matrix
            yPos =parseInt(h/(height/(vectors.length-1)));
            
            //relative vectors to the pixel
            let vec1 = vectors[yPos+1][xPos];
            let vec2 = vectors[yPos][xPos];
            let vec3 = vectors[yPos+1][xPos+1];
            let vec4 = vectors[yPos][xPos+1];
            
            //position from 0 to 1 on y
            let mapedY = map(
                h%(height/(vectors.length-1)), 
                0, 
                height/(vectors.length-1), 
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
             
            //linear interpolation
            //let c = f1*(1-mapedX)*(1-mapedY) + f3*mapedX*(1-mapedY)
              //      + f2*(1-mapedX)*mapedY + f4*mapedX*mapedY;
            //console.log(c);                   
            //print(w,h,v2);
            stroke(0);
            strokeWeight(4);
            
            point(w,h,map(v2, 0, 1, 0, 150));
            
            
        }
    }
    
    //updatePixels();
    resArr();
}
function resArr(){
    vectors=[];
    for(let i=0; i<width; i+=offset){
        let aux = []; 
        for(let j=0; j<height; j+=offset){
            let p = createVector(
                random(-1, 1),
                random(-1, 1)
            ).normalize();

           
            aux.push(p);
            
        }
        vectors.push(aux);
    }

}