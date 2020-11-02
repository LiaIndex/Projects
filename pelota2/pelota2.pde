import peasy.*;
import java.util.*;

int _n = 600;
int _r = 90;
int seed;
float angle = 0;

float maxHeightLevel = 0;
float seaLevel;
PeasyCam cam;

boolean debugColor = false;
boolean seaSmooth = false;
//for camera
boolean _renderOneFace = true;

PVector zp[] = new PVector[ _n * _n];
PVector zn[] = new PVector[ _n * _n];

PVector yp[] = new PVector[ _n * _n];
PVector yn[] = new PVector[ _n * _n];

PVector xp[] = new PVector[ _n * _n];
PVector xn[] = new PVector[ _n * _n];

Map<String, PVector[]> cube;

PVector[] facesMainVectors = {
      new PVector(0,0,1), //zp
      new PVector(0,0,-1), //zn
      new PVector(1,0,0), //xp
      new PVector(0,1,0), //yp
      new PVector(-1,0,0), //xn
      new PVector(0,-1,0), //yn
  };

public color[] waterPalette =
    {//earth like
    #00429d,#1649a0,#2351a4,#2d58a7,#3660ab,#3e67ae,#456fb2,#4d77b5,#547fb8,#5b87bb,#618fbf,#6896c2,#6f9ec5,#77a6c8,#7eafcb,#85b7ce,#8dbfd1,#95c7d3,#9ecfd6,#a7d7d8,#b1dfdb,#bbe6dd
    };
    
    
public color[] surfacePalette =
    {//earth like
    #d1de45,#c9d93d,#c0d336,#b7cd2f,#adc628,#a2be21,#97b71a,#8baf13,#7fa60d,#729e07,#659403,#578b01,#488100,#437801,#487103,#4d6c06,#516609,#54620e,#585f12,#5c5c16,#605a1b,#645920,#685925,#6d5a2b,#725c31,#775e38,#7d623f,#836648,#896b51,#90725b,#977965,#9e8271,#a68c7e,#ad968c,#b5a29a,#bdafaa,#c5bebb,#cdcdcd};



Map<String, PVector[]> generateCube(){
  
  Map<String, PVector[]> map = new HashMap<String, PVector[]>();
  
  for (int i=0; i<_n*_n; i++){
   float colref = i / _n;
   float rowref = i % _n;
   float a = map(colref, 0, _n - 1, -1.0, 1.0);
   float b = map(rowref, 0, _n - 1, -1.0, 1.0);
   
   zp[i] = new PVector(a,b,1).mult(_r).setMag(_r);
   zn[i] = new PVector(a,b,-1).mult(_r).setMag(_r);
   
   yp[i] = new PVector(a, 1, b).mult(_r).setMag(_r);
   yn[i] = new PVector(a, -1, b).mult(_r).setMag(_r);
   
   xp[i] = new PVector(1, a, b).mult(_r).setMag(_r);
   xn[i] = new PVector(-1, a, b).mult(_r).setMag(_r);
   
   
  }
  
  map.put("positive_x", xp);
  map.put("negative_x", xn);
  
  map.put("positive_y", yp);
  map.put("negative_y", yn);
  
  map.put("positive_z", zp);
  map.put("negative_z", zn);
  
  return map;
}



void render( Map<String, PVector[]> map){
  //get camera pos
  
  float[] cameraPos = cam.getPosition();
  PVector camPos = new PVector(cameraPos[0], cameraPos[1], cameraPos[2]);
  
  //get xp, xn, yp... vectors
  
  //calculate the distance
  float distance = 999999999;
  int index = 0;

  for(int i=0; i<facesMainVectors.length; i++){
    float auxDist = camPos.dist(facesMainVectors[i]);
    if(auxDist <= distance){
        distance = auxDist;
        index = i;
    }  
  }
  //print(index +"\n");
  //show the face corresponding to the shorter distance
  int indexForRendering = 0;
  for(Map.Entry<String, PVector[]> entry : map.entrySet()){
    
    //for some reason java puts the thins on the map
    //not in the map.putxxx order 
    //print("indexForRendering : "+indexForRendering +"entry : "+entry.getKey()+"\n");
    //only render the nearest face
    //print(index+" "+indexForRendering+"\n");
    if(indexForRendering != index && _renderOneFace){ indexForRendering ++; continue;}
      PVector[] face = entry.getValue();
      int tik = 0;
      beginShape(QUAD_STRIP);
      for(int i=0; i<face.length; i++){
        //   . - . - .
        //   |   |   |
        //   . - . - .
        //   |   |   |
        //   . - . - .
        if(tik == _n){
            endShape();
            beginShape(QUAD_STRIP);
            tik=0;
        }
        
        if(!debugColor){
          if(!seaSmooth){
            //for color
            if( face[i].mag() <= _r + seaLevel ){
              fill(
                waterPalette[ (int) map( 
                  face[i].mag(), 
                  _r, 
                  _r+seaLevel, 
                  0, waterPalette.length-1)
                ]
              );
            }
            else{
              fill(
                surfacePalette[ (int) map(
                  face[i].mag(), 
                  _r+seaLevel, 
                  _r+maxHeightLevel, 
                  0, surfacePalette.length-1)
                 ]
               );
            }
          }//seasmooth
          else{
            if(face[i].mag() <= _r + seaLevel+0.01)fill(0,0,255);
            else fill( surfacePalette[ (int) map( face[i].mag(),_r+seaLevel,_r+maxHeightLevel,0, surfacePalette.length-1)]);
          }
         }//debug color if
         
         
        vertex(face[i].x,face[i].y,face[i].z);
        if(i+_n < face.length) vertex(face[i+_n].x,face[i+_n].y,face[i+_n].z);
        tik++;
      }
      endShape();
      
      indexForRendering ++;
  }
  
}

Map<String, PVector[]> alterCubeMagnitudes(Map<String, PVector[]> cube){
  noiseSeed(seed);
  noiseDetail(8,0.64);
  
  //noiseScale controls the excentricity,
  //it can be used to control the above sea level terrain dispersity
  //between values of 0.02 and 0.04, continents and big islands will 
  //be generated, a planet full of islands will have values like 0.09 or 0.1
  float noiseScale = 0.025;
  //max and min height of a point
  float maxHeight = 10;
  float minVal = maxHeight *1.5 / 10.0;
  
  for(Map.Entry<String, PVector[]> entry : cube.entrySet()){
    PVector[] face = entry.getValue();
    
    for(int i=0; i<face.length; i++){
     
      PVector aux = face[i];
      
      //for a more smooth result and not so bumpy, interpolate each points with the center
      //PVector vectorBetween = aux.lerp(new PVector(0,0,0),0);
      
      //print(vectorBetween.x, vectorBetween.y, vectorBetween.z + "\n");
      float noise3 = noise(aux.x * noiseScale + _r, 
                           aux.y * noiseScale + _r, 
                           aux.z * noiseScale + _r);
      
      //based on the function (1-|sin(x)|)^2
      float noiseVal =   1 -  noise3 ;
      //if(noiseVal > 0.8) 
      //print(noiseVal + "\n");
      noiseVal *= noiseVal;
      
     // if(noiseVal > 0.6)print(noiseVal + "\n");
      
      float heightMag = map(noiseVal, 0, 0.8, 0, maxHeight);
      seaLevel = minVal;
      if(seaSmooth){
        if(heightMag - minVal <= 0)
          heightMag = minVal;
        //seaLevel = 0.2 ;
      }
      if(heightMag>maxHeightLevel) maxHeightLevel = heightMag;
      aux.setMag(_r + heightMag);
      //print(_r + heightMag +"\n");
    }
  }
  return cube;
}


void setup(){
  size(600,600,P3D);
  cam = new PeasyCam(this,100);
  cam.setMinimumDistance(180);
  cam.setMaximumDistance(2000);
  cam.setDistance(250);
  
  
  cube = generateCube();
  seed = 0;//(int)random(999999999);
  //seed = 189928896;
  cube = alterCubeMagnitudes(cube);
  
  
  //189928896
  //0
  print("Generated world: "+seed+"\n"+
        "Vertices per face: "+_n*_n+"\n"+
        "Radius: "+_r+"\n"+
        "Sea level at: "+seaLevel+"\n"+
        "Maximum height archieved: "+maxHeightLevel+"\n"+
        "Debug color:" +debugColor + "\n"+
        "Full render: "+!_renderOneFace+"\n"+
        "Noise layers: 8\nNoise layers falloff: 64%\nNoise scale: 2.5%");

}
void draw(){
  background(120);
  
  lights();
  text(frameRate, _r*2,0);
  /*rotateX(angle);
  rotateY(angle);
  angle += 0.01;
  */
  
  strokeWeight(3);
  stroke(color(255,0,0));
  line(0,0,0,_r*2,0,0);
  stroke(color(0,255,0));
  line(0,0,0,0,_r*2,0);
  stroke(color(0,0,255));
  line(0,0,0,0,0,_r*2);
  
  if(debugColor){
    stroke(0);
    fill(240);
  }
  strokeWeight(0.5);
  if(!debugColor) noStroke();
  //noFill();
  render(cube);
  
  
}
