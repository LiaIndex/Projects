/*Title: Perlin Noise Cosine Interpolation
Author Lia de Belda
example of Perlin algorithm in P5
See: 
https://en.wikipedia.org/wiki/Perlin_noise
https://wiki.freepascal.org/Perlin_Noise
http://www.arendpeter.com/Perlin_Noise.html
*/
let checkbox;

let condicion = true;
let flow = true;
let res;
let width = 350;
let height = 350;
let vectors = [];
let pg;
let turbulence;
let detail;
//number of boxes = denominator
let offset1 = width/10;
let offset2 = height/10;

let offsetV1 = width/10;
let offsetV2 = height/10;

let res2;

function setup(){
    
  createCanvas(width, height,WEBGL);
  stroke(0);
  strokeWeight(1);
  
  //set the array of vectors
  resArr();
  res = getPerlin3DPoints();
  res2 = getPerlin3DPoints();
  turbulence = createSlider(0.5, 4.5, 0.5);
  detail = createSlider(1, 4, 0.5);
  turbulence.position(20, 20);
  detail.position(20, 40);
  
  checkbox = createCheckbox('flow', true);
  checkbox.changed(myCheckedEvent);
  checkbox.position(20, 0);
}

function myCheckedEvent() {
  if (this.checked()) {
    flow = true;
  } else {
    flow = false;
  }
}

function draw(){
  
  orbitControl();
  noFill();
  scale(0.90);
  frameRate(60);
  translate(width/2,height/2);
  rotate(PI);
  rotateX(-PI/4);
  background(0);
  
  //offsetAuxV and ..Aux are used to check if the value
  //of the sliders has change from the previous iteration
  let offsetAuxV = offsetV1;
  let offsetAux = offset1;
  
  //Aumenting the number of reference vectors cause a more sensible
  //system, resulting in more turbulence
  offsetV1 =(width/10) / turbulence.value();
  offsetV2 =(height/10) / turbulence.value();
  //Aumenting the number of vectors used  to calculate  the z component
  //provides  a more detailed system
  offset1 = (width/10) / detail.value();
  offset2 = (height/10) / detail.value();
  //if the slider changes is needed a recalculation of the reference
  //and also recalculate the perlin values
  
  if( (offsetAuxV != offsetV1) || (offsetAux != offset1) ){
    resArr();
    res = getPerlin3DPoints();
    res2 = getPerlin3DPoints();
  }

  /**
  * In order to generate the field dinamically, a new set of values
  * are calculated and stored in res2, then the data is passed from res2
  * to res one row at time
  **/
  let auxZ = [];
  if(!flow){
  for(let iz=0; iz<res2.length; iz++){
      auxZ.push( res2[iz].shift().z );
  }}
  
  /**
  *  then all the rows must update and go down 1 step
  *  when that is done, the last one is updated with the 
  *  data from res2 
  **/
  //abajo
  
  if(!flow){
    for(let iz2=0; iz2<res.length; iz2++){
      //izquierda
      for(let iz3=0; iz3<res[iz2].length-1; iz3++){
        res[iz2][iz3].z = res[iz2][iz3+1].z;
      }
    }

    for(let iz4=0; iz4<res.length; iz4++){
        res[iz4][res.length-1].z = auxZ[iz4];
    }
  }
  
  if(flow){
  resArr2();
  res = getPerlin3DPoints();
  }
  /**
  *  for  last when all the data from res2 has passed to res
  *  then res2 is updated with more data
  *  TODO:   improve the solaping for better results
  **/
  
  if(!flow){
  if(res2[0].length < 1){
        resArr();
        res2 = getPerlin3DPoints();
  }}
  
  stroke(240);
  for(let i=0; i<res.length; i++){
    /**
      * for debbuging 
      -------------------
        stroke(255,0,0);
        strokeWeight(25);
        point(res[i][0].x,
                 res[i][0].y,
                 res[i][0].z);
        stroke(0)
        strokeWeight(1);
      
      *    
    **/
    
    /**
    *  __ __
    * |\ |\
    *
    **/
    
    beginShape();
    for(let j=0; j<res[i].length; j++){
      if(j == res.length -1 && i < res.length -1){
        vertex(
            res[i][j].x,
             res[i][j].y,
             res[i][j].z);
        vertex(
             res[i+1][j].x,
             res[i+1][j].y,
             res[i+1][j].z
        );
      }else if(i == res.length-1 && j < res.length -1){
        vertex(
            res[i][j].x,
            res[i][j].y,
            res[i][j].z);
        vertex(
            res[i][j+1].x,
            res[i][j+1].y,
            res[i][j+1].z
        );
      }
      else if( i < res.length -1 && j < res.length -1){
        vertex(
             res[i][j].x,
             res[i][j].y,
             res[i][j].z);
        vertex(
             res[i][j+1].x,
             res[i][j+1].y,
             res[i][j+1].z
        );
        vertex(
          res[i+1][j].x,
          res[i+1][j].y,
          res[i+1][j].z);
        vertex(
          res[i][j].x,
          res[i][j].y,
          res[i][j].z
        );
        
      
      }//elseif
    }//for
    endShape();
  }//for
  
  //adds a bit more of randomess
  //resArr2();
  
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
    for(let i=0; i<width; i+=offsetV1){
        let aux = []; 
        for(let j=0; j<height; j+=offsetV2){
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
            vectors[i][j].rotate(random(0, PI/25));
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
    let con = 0;
    for(let w=0; w<width; w+=offset1){
        //x position on the vectors matrix
        xPos =parseInt(w/(width/(vectors.length-1)));
        //position from 0 to 1 on x
        let mapedX = map(
            w%(width/(vectors.length-1)),
            0,
            width/(vectors.length-1),
            0,1
        );
        for(let h=0; h<height; h+=offset2){
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
            /*
            let c = f1*(1-mapedX)*(1-mapedY) +
                    f3*mapedX*(1-mapedY) +
                    f2*(1-mapedX)*mapedY +
                    f4*mapedX*mapedY;
            */
            //console.log(c);                   
            
            let alt = map(v2, 0, 1, 0, 45);
            
            
            resAux.push({x:w, y:h, z:alt});
         }
      
        res_.push(resAux);
        resAux = [];
     }
     return res_;
}
