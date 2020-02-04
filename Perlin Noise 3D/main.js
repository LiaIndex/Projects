/*Title: Perlin Noise Cosine Interpolation
Author Lia de Belda
example of Perlin algorithm in P5
See: 
https://en.wikipedia.org/wiki/Perlin_noise
https://wiki.freepascal.org/Perlin_Noise
http://www.arendpeter.com/Perlin_Noise.html
*/
let condicion = true;
let res;
let width = 600;
let height = 600;
let vectors = [];
let pg;
let turbulence;
let detail;
//number of boxes = denominator
let offset = width/10;
let offsetV = width/10;

function setup(){
    
  createCanvas(width, height,WEBGL);
  stroke(0);
  strokeWeight(1);
  
  //set the array of vectors
  resArr();
  res = getPerlin3DPoints();
  turbulence = createSlider(1, 8, 3);
  detail = createSlider(1, 8, 3);
  turbulence.position(20, 20);
  detail.position(20, 40);
  
}


function draw(){
  if(touches.length > 0)resArr();
  orbitControl();
  scale(0.5);
  frameRate(25);
  translate(width/2,-height/2);
  rotateY(PI);
  rotateX(-PI/4);
  background(255);
  
  let offsetAuxV = offsetV;
  offsetV =(width/10) * turbulence.value();
  if(offsetAuxV != offsetV){resArr();}
  offset = (width/10) / detail.value();
  
 res = getPerlin3DPoints();

  for(let i=0; i<res.length; i++){
    for(let j=0; j<res[i].length; j++){
      if(j == res.length -1 && i < res.length -1){
        line(
            res[i][j].x,
             res[i][j].y,
             res[i][j].z,
             res[i+1][j].x,
             res[i+1][j].y,
             res[i+1][j].z
        );
      }else if(i == res.length-1 && j < res.length -1){
        line(
            res[i][j].x,
            res[i][j].y,
            res[i][j].z,
            res[i][j+1].x,
            res[i][j+1].y,
            res[i][j+1].z
        );
      }
      else if( i < res.length -1 && j < res.length -1){
        line(
             res[i][j].x,
             res[i][j].y,
             res[i][j].z,
             res[i][j+1].x,
             res[i][j+1].y,
             res[i][j+1].z
        );
        line(
          res[i+1][j].x,
          res[i+1][j].y,
          res[i+1][j].z,
          res[i][j].x,
          res[i][j].y,
          res[i][j].z
        );
        line(
          res[i+1][j].x,
          res[i+1][j].y,
          res[i+1][j].z,
          res[i][j+1].x,
          res[i][j+1].y,
          res[i][j+1].z
        );
      }//elseif
    }//for
  }//for
  /*let auxM = res[res.length-1];
  for(let k=res.length-1; k>0;k--){
res[k]=res[k-1];
}
  res[0] = auxM;*/
  resArr2();
  
}

/**
*
* resArr will initialize the reference vectors
* later those reference vectors will be used to 
* calculate the Perlin Vectos
*
**/
function resArr(){
    vectors=[];
    for(let i=0; i<width; i+=offsetV){
        let aux = []; 
        for(let j=0; j<height; j+=offsetV){
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
            vectors[i][j].rotate(random(0, PI/50));
        }
    }
}

/**
* return a matrix of points (x,y,z) where x and y 
* are calculated using offset and z is a mapping
* from v2, wich are the perlin values, those perlin
* values are calculated using cosine interpolation
* wich gives more smoothness, in the code is comented
* the linear interpolation, wich is the regular way to
* do it
**/

function getPerlin3DPoints(){
    let xPos;
    let yPos;
    let resAux = [];
    let res_ = [];
    
    for(let w=0; w<width; w+=offset){
        //x position on the vectors matrix
        xPos =parseInt(w/(width/(vectors.length-1)));
        //position from 0 to 1 on x
        let mapedX = map(
            w%(width/(vectors.length-1)),
            0,
            width/(vectors.length-1),
            0,1
        );
        for(let h=0; h<height; h+=offset){
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
            let alt = map(v2, 0, 1, 0, 150);
            
            //point(w,h,alt);
            resAux.push({x:w, y:h, z:alt});
            /*
            push();
            translate(w,h,0);
            box(offset,offset,alt);
            pop();
            */
            
        }
        res_.push(resAux);
        resAux = [];
     }
     return res_;
}
