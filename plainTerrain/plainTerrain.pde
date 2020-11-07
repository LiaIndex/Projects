import peasy.*;

int detail;
PVector[] field;
PVector[] stars;
float xOffset;
float yOffset;
float noiseScale;
float displacement;
int maxHeight;
boolean stop;
PeasyCam cam;
float heightestPoint;
float minimumHeight;
float seaLevel;
boolean seaSmooth;
boolean renderWireFrame;
boolean dayMode;
boolean eveningMode;
boolean nightMode;
boolean renderLightAndShadows;
int det;

public color[] waterPalette =
    {//earth like
    #00429d,#1649a0,#2351a4,#2d58a7,#3660ab,#3e67ae,#456fb2,#4d77b5,#547fb8,#5b87bb,#618fbf,#6896c2,#6f9ec5,#77a6c8,#7eafcb,#85b7ce,#8dbfd1,#95c7d3,#9ecfd6,#a7d7d8,#b1dfdb,#bbe6dd
    };
public color[] surfacePalette =
    {//earth like
    #d1de45,#c9d93d,#c0d336,#b7cd2f,#adc628,#a2be21,#97b71a,#8baf13,#7fa60d,#729e07,#659403,#578b01,#488100,#437801,#487103,#4d6c06,#516609,#54620e,#585f12,#5c5c16,#605a1b,#645920,#685925,#6d5a2b,#725c31,#775e38,#7d623f,#836648,#896b51,#90725b,#977965,#9e8271,#a68c7e,#ad968c,#b5a29a,#bdafaa,#c5bebb,#cdcdcd};


//BETA
void keyPressed(){

  if(key == 'j'){
    det+=100;
    initTerrain(det);
    alterHeights();
    printLog();
  }
  else if(key == 'l'){
    det -=100;
    if(det<100)det = 100;
    initTerrain(det);
    alterHeights();
    printLog();
  } 
}


void printLog(){

  print(
    "Debug list :\n"+
    "theoritical max height: " + maxHeight +"\n"+
    "max point: " + heightestPoint +"\n"+
    "min point: " + minimumHeight +"\n"+
    "sea level: " + seaLevel + "\n"+
    "number of points: "+ detail * detail +"\n"+
    "seaSmooth: "+ seaSmooth +"\n" +
    "render wireframe: "+renderWireFrame + "\n");
    
    String mode = "Day mode: ";
    if(dayMode) mode += "moorning";
    else if(eveningMode) mode += "evening";
    else mode += "night";
    
    print( mode +"\nrender lights and shadows: "+renderLightAndShadows);

}

void initTerrain(int d){

  detail = d;
  field = new PVector[detail * detail];
  xOffset = 0;
  yOffset = 0;
  maxHeight = 150;
  displacement = 0.05;
  stop = true;
  heightestPoint = 0;
  minimumHeight = 999;
  seaSmooth = true;
  renderWireFrame = false;
  renderLightAndShadows = true;
  
  dayMode = true;
  eveningMode = false;
  nightMode = false;
  
  if(nightMode){
    stars = generateStars(300, 1500);
  }
    
  
  int w = width/detail;
  int h = height/detail;
  
  for(int i=0; i<field.length; i++){
    float posX = (i % detail) * w ;
    float posY = (i / detail) * h;
    field[i] = new PVector(posX, posY, 0);
  }
  
  noiseDetail(8, 0.44);
  noiseScale = 0.01;
  
  
  
  
}


void alterHeights(){
  
  for(int i=0; i<field.length; i++){
   
    float h = 0;
    PVector p = field[i];
    float noiseValue = noise(
        p.x * noiseScale + xOffset,
        p.y * noiseScale + yOffset
      );
    
    //decomment for island like terrain
    if(seaSmooth)
      noiseValue = max(0.35, noiseValue);
    
    //uncomment for more sharpness in the mountains
    noiseValue *= noiseValue;
    h = noiseValue * maxHeight;
    if(h > heightestPoint) heightestPoint = h;
    if(h < minimumHeight) minimumHeight = h;
    p.z = h;
  }
  
}

PVector[] generateStars(int numberOfPoints, int radius){
    PVector[] points = new PVector[numberOfPoints];
    float gr = (float) (1+Math.sqrt(5)/2);
    float lambda = PI * gr;
    float inc = gr / 10;
    
    for(int i=0; i<numberOfPoints; i++){
      gr += inc;
      lambda = PI * gr;
      float t = (float)i/numberOfPoints;
      float a1 = acos(1-2*t);
      float a2 = lambda * i;
      float x = sin(a1) * cos(a2);
      float y = sin(a1) * sin(a2);
      float z = cos(a1);
      PVector p = new PVector(x,y,z).mult(radius);
      points[i] = p;
               
    }
    return points;
}


void renderField(){
  if(renderWireFrame){
    stroke(0);
    strokeWeight(0.5);
  } 
  else
    noStroke();
  //fill(0);
  beginShape(TRIANGLE_STRIP);
  
  for(int i=0; i<field.length - detail; i++){
    if(i%detail == 0){
      endShape();
      beginShape(TRIANGLE_STRIP);
    }
    color c;
    if(field[i].z <= seaLevel){
      //under sea level use water palette
      c = waterPalette[ (int)map(field[i].z, minimumHeight, seaLevel, 0, waterPalette.length - 1)];
      
    }else{
      c = surfacePalette[ (int)map(field[i].z, seaLevel, heightestPoint, 0, surfacePalette.length - 1)];
     
    }
    fill(c);
    PVector p = field[i];
    PVector p2 = field[i + detail];
    vertex(p.x, p.y, p.z);
    vertex(p2.x, p2.y, p2.z);
    
  }
  endShape();
}

void renderStars(){
  stroke(255);
    for(int i=0; i<stars.length; i++){
      strokeWeight(random(1,2));
      point(stars[i].x,stars[i].y,stars[i].z);
   }
  noStroke();
}

void renderLightsAndShadows(){
  float xCamPosNorm = map(mouseX, 0, width, 1, -1);
  float yCamPosNorm = map(mouseY, 0, height, 1, -1);
  float zCamPosNorm = -0.59;
  //print("mouseX : "+mouseX+"\nmouseY: "+mouseY+"\n");
  
  if(dayMode){
    directionalLight(250, 250, 200, xCamPosNorm, yCamPosNorm, zCamPosNorm);
  }
  else if(nightMode){
    directionalLight(80, 80, 180, xCamPosNorm, yCamPosNorm, zCamPosNorm);
    renderStars();
  }else if(eveningMode){
    directionalLight(80, 80, 180, xCamPosNorm, yCamPosNorm, zCamPosNorm);
    renderStars();
  }
  
  ambientLight(0,0,0);
}

void setup(){
  size(800,600,P3D);
  //camera settings
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(1000);
  cam.setDistance(200);
  frameRate(60);
  
  //initialize field
  det = 256;
  initTerrain(det);
  //set the points height's using perlin noise
  alterHeights();
  
  //correct color palette 
  if(seaSmooth)
    seaLevel = minimumHeight + (float)heightestPoint/10.0;
  else
    seaLevel = minimumHeight + (float)heightestPoint/6.0;
    
   
    
  //print creation details
  printLog();
}

void draw(){
  
  background(0);
  translate(- width/2.1 ,0, -height*1.2);
  rotateX(PI/5);
  //yOffset -= 0.1;
  //movement
  switch(key){
    case 'w':
      yOffset -= displacement;
      break;
    case 's':
      yOffset += displacement;
      break;
    case 'a':
      xOffset -= displacement;
      break;
    case 'd':
      xOffset += displacement;
      break;
    case '1':
      renderLightAndShadows = false;
      break;
    case '2':
      renderLightAndShadows = true;
   }
  
  
  if(renderLightAndShadows){
    renderLightsAndShadows();
  }
  
  alterHeights();
  renderField();
}
