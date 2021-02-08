import peasy.*;

int detail;
PVector[] field;
PVector[] seaField;
PVector[] stars;
float xOffset;
float yOffset;
float xOffsetSea;
float yOffsetSea;
float noiseScale;
float displacement;
float initialDisplacementFromOriginX;
float initialDisplacementFromOriginY;
int maxHeight;
boolean stop;
PeasyCam cam;
float heightestPoint;
float minimumHeight;
float seaLevel;
boolean renderSea;
boolean renderWireFrame;
boolean dayMode;
boolean eveningMode;
boolean nightMode;
boolean renderLightAndShadows;
boolean semiOpaqueSea;
int det;
//bugged
PGraphics sea_pg;
PShape sf;

public color[] waterPalette =
    {//earth like
    #00429d,#1649a0,#2351a4,#2d58a7,#3660ab,#3e67ae,#456fb2,#4d77b5,#547fb8,#5b87bb,#618fbf,#6896c2,#6f9ec5,#77a6c8,#7eafcb,#85b7ce,#8dbfd1,#95c7d3,#9ecfd6,#a7d7d8,#b1dfdb,#bbe6dd
    };
public color[] surfacePalette =
    {//earth like
    #d1de45,#c9d93d,#c0d336,#b7cd2f,#adc628,#a2be21,#97b71a,#8baf13,#7fa60d,#729e07,#659403,#578b01,#488100,#437801,#487103,#4d6c06,#516609,#54620e,#585f12,#5c5c16,#605a1b,#645920,#685925,#6d5a2b,#725c31,#775e38,#7d623f,#836648,#896b51,#90725b,#977965,#9e8271,#a68c7e,#ad968c,#b5a29a,#bdafaa,#c5bebb,#cdcdcd};


//BETA
void keyPressed(){

  if(key == '+'){
    initialDisplacementFromOriginX += xOffset;
    initialDisplacementFromOriginY += yOffset;
    xOffset = 0;
    yOffset = 0;
    det+=128;
    initTerrain(det);
    alterHeights();
    printLog();
  }
  else if(key == '-'){
    initialDisplacementFromOriginX += xOffset;
    initialDisplacementFromOriginY += yOffset;
    xOffset = 0;
    yOffset = 0;
    det -= 128 ;
    if(det<128)det = 128;
    initTerrain(det);
    alterHeights();
    printLog();
  } 
  else if(key == 'h'){
    if(sf == null){
       print("trying to make model...");
       sf = createStaticFrame();
     }
     else
       sf = null;
  }
}


void keyBoardControl(){

   //movement
  switch(key){
    case 'w':
      yOffset -= displacement;
      initialDisplacementFromOriginY -= displacement;
      break;
    case 's':
      yOffset += displacement;
      initialDisplacementFromOriginY += displacement;
      break;
    case 'a':
      xOffset -= displacement;
      initialDisplacementFromOriginX -= displacement;
      break;
    case 'd':
      xOffset += displacement;
      initialDisplacementFromOriginX += displacement;
      break;
    case 'q':
      yOffset -= displacement;
      initialDisplacementFromOriginY -= displacement;
      xOffset -= displacement;
      initialDisplacementFromOriginX -= displacement;
      break;
    case 'e':
      yOffset -= displacement;
      initialDisplacementFromOriginY -= displacement;
      xOffset += displacement;
      initialDisplacementFromOriginX += displacement;
      break;
    case 'z':
      xOffset -= displacement;
      yOffset += displacement;
      initialDisplacementFromOriginY += displacement;
      initialDisplacementFromOriginX -= displacement;
      break;
    case 'c':
      xOffset += displacement;
      yOffset += displacement;
      initialDisplacementFromOriginY += displacement;
      initialDisplacementFromOriginX += displacement;
      break;
    case 'i':
      yOffsetSea -= displacement;
      break;
    case 'k':
      yOffsetSea += displacement;
      break;
    case 'j':
      xOffsetSea -= displacement;
      break;
    case 'l':
      xOffsetSea += displacement;
      break;
    //for debugging
    case '1':
      renderLightAndShadows = false;
      break;
    case '2':
      renderLightAndShadows = true;
      break;
    case '3':
      renderWireFrame = true;
      break;
    case '4':
      renderWireFrame = false;
      break;
    case '5':
      renderSea = true;
      break;
    case '6':
      renderSea = false;
      break;
    case 'b':
      dayMode = true;
      nightMode = false;
      eveningMode = false;
      break;
    case 'n':
      dayMode = false;
      nightMode = true;
      eveningMode = false;
      if(stars == null)stars = generateStars(300, 1500);
      break;
    case 'm':
      dayMode = false;
      nightMode = false;
      eveningMode = true;
      if(stars == null)stars = generateStars(300, 1500);
      break;
   }

}

void printLog(){

  print(
"\n"+    
"  _______                      _      \n"+
" |__   __|                    (_)     \n"+
"    | | ___ _ __ _ __ __ _ ___ _ ___  \n"+
"    | |/ _ \\ '__| '__/ _` / __| / __| \n"+
"    | |  __/ |  | | | (_| \\__ \\ \\__ \\ \n"+
"    |_|\\___|_|  |_|  \\__,_|___/_|___/ \n"+
                                     
    "\nPlain terrain generation v0.2, Lia Belda Calvo\n"+
    "----------------------------------------------\n"+
    "Debug list :\n\n"+
    
    "Noise Settings \n"+
    "-------------- \n"+
    "Noise Scale: "+noiseScale +"\n"+
    "Noise layers and falloff: 8, 44% \n"+
    "Theoritical max height: " + maxHeight +"\n"+
    "Max point: " + heightestPoint +"\n"+
    "Min point: " + minimumHeight +"\n"+
    "Initial displacement from the noise origin on X: "+initialDisplacementFromOriginX+"\n"+
    "Initial displacement from the noise origin on Y: "+initialDisplacementFromOriginY+"\n\n"+
    
    
    "Terrain settings \n"+
    "---------------- \n"+
    "Initial detail: "+detail+"\n"+
    "Number of points: "+ detail * detail +"\n"+
    //"Sea smooth: "+ seaSmooth +"\n" +
    "sea level: " + seaLevel + "\n"+
    "Render Wireframe: "+renderWireFrame + "\n"+
    
    "Light settings \n"+
    "-------------- \n");
    
    String mode = "Day mode: ";
    if(dayMode) mode += "moorning";
    else if(eveningMode) mode += "evening";
    else mode += "night";
    
    print( mode +"\n"+
    "Render lights and shadows: "+renderLightAndShadows+"\n\n\n");
    
    print(
      "+++++++++++++++++++++++++++++++++++\n"+
      "Instructions: \n"+
      "1 & 2 On/Off lights\n"+
      "3 & 4 On/Off wireframes\n"+
      "5 & 6 On/Off Sea\n"+
      "b,n,m swtches day, night, evening\n"+
      "w,a,s,d move up, down, left, right \n"+
      "q,e,z,c move in diagonals\n"+
      "h, capture the frame to make an static frame, with this the performance \nwill increase a lot, to be able to move again press h again\n"+
      "NOT FINISHED, PLENTTY OF BUGS ->  +,- duplicate/half detail\n"+
      "+++++++++++++++++++++++++++++++++++\n\n"
    
    );

}

void initTerrain(int d){

  detail = d;
  field = new PVector[detail * detail];
  seaField = new PVector[detail * detail];
  xOffset = 0;
  yOffset = 0;
  xOffsetSea = 0;
  yOffsetSea = 0;
  maxHeight = 150;
  displacement = 0.0125;
  
  stop = true;
  heightestPoint = 0;
  minimumHeight = 999;
  //seaSmooth = false;
  renderWireFrame = false;
  renderLightAndShadows = true;
  renderSea = true;
  dayMode = true;
  eveningMode = false;
  nightMode = false;
  
  if(nightMode){
    stars = generateStars(300, 1500);
  }
  
  
  float w = (float)width / (float)detail;
  float h = (float)height / (float)detail;
  
  print("width: "+width+"\nheight: "+height+"\nw: "+w+"\nh: "+h);
  
  for(int i=0; i<field.length; i++){
    float posX = (i % detail) * w ;
    float posY = (i / detail) * h;
    field[i] = new PVector(posX, posY, 0);
    seaField[i] = new PVector(posX, posY, 0);
  }
  
  //noiseDetail(8, 0.44);
  noiseDetail(8, 0.45);
  //noiseScale = 0.008;
  
  //used when 1-abs
  noiseScale = 0.0019;
  
  
}


void alterHeights(){
  //uncomment this when using the angle mapping and the 1-abs
  //noiseScale = 0.0022; 0.0019 give better results
  
  for(int i=0; i<field.length; i++){
   
    float h = 0;
    PVector p = field[i];
    float noiseValue = noise(
        p.x * noiseScale + xOffset + initialDisplacementFromOriginX,
        p.y * noiseScale + yOffset + initialDisplacementFromOriginY
      );
    
    //decomment for island like terrain
    //if(seaSmooth)
    //noiseValue = max(0.20, noiseValue);
    
    //use this angle + the 1-abs formula to get sharpness in the mountains
    //when doing that turn off seaSmooth.
    
    float angle = map(noiseValue, 0, 1, -PI, PI);
    noiseValue = 1-abs(sin(angle));
    
    h = noiseValue * maxHeight ;
    if(h > heightestPoint) heightestPoint = h;
    if(h < minimumHeight) minimumHeight = h;
    p.z = h;
  }
  
}

void alterHeightsSea(){
  noiseDetail(4, 0.5);
  float seaNoiseScale =0.02;
  for(int i=0; i<seaField.length; i++){
   
    PVector p = seaField[i];
    float noiseValue = noise(
        p.x * seaNoiseScale + xOffsetSea + initialDisplacementFromOriginX,
        p.y * seaNoiseScale + yOffsetSea + initialDisplacementFromOriginY
      );
    
    p.z = (noiseValue * 5) + seaLevel ;
  }
  
  noiseDetail(8, 0.45);
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
      
      c = surfacePalette[ (int)map(field[i].z, seaLevel, heightestPoint, 0, surfacePalette.length - 1 )];
    }
    fill(c);
    PVector p = field[i];
    PVector p2 = field[i + detail];
    vertex(p.x, p.y, p.z);
    vertex(p2.x, p2.y, p2.z);
    
  }
  endShape();
}






void renderSeaField(){
  
  beginShape(TRIANGLE_STRIP);
  
  for(int i=0; i<seaField.length - detail; i++){
    if(i%detail == 0){
      endShape();
      beginShape(TRIANGLE_STRIP);
    }
    
    if(field[i].z > seaLevel + 1)
      fill(color(#5580ff, 0));
    else
      fill(color(#5580ff, 160));
    PVector p = seaField[i];
    PVector p2 = seaField[i + detail];
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
    directionalLight(227, 168, 87, xCamPosNorm, yCamPosNorm, zCamPosNorm);
    renderStars();
  }
  
  ambientLight(0,0,0);
}


PShape createStaticFrame(){
  PShape staticField = createShape(GROUP);
  PShape auxShape = createShape();
  auxShape.beginShape(TRIANGLE_STRIP);
  
  for(int i=0; i<field.length - detail; i++){
    if(i%detail == 0){
      auxShape.endShape();
      staticField.addChild(auxShape);
      auxShape = createShape();
      auxShape.beginShape(TRIANGLE_STRIP);
    }
    color c;
    if(field[i].z <= seaLevel){
      //under sea level use water palette
      c = waterPalette[ (int)map(field[i].z, minimumHeight, seaLevel, 0, waterPalette.length - 1)];
      
    }else{
      c = surfacePalette[ (int)map(field[i].z, seaLevel, heightestPoint, 0, surfacePalette.length - 1 )];
    }
    auxShape.fill(c);
    PVector p = field[i];
    PVector p2 = field[i + detail];
    auxShape.vertex(p.x, p.y, p.z);
    auxShape.vertex(p2.x, p2.y, p2.z);
    
  }
  auxShape.endShape();
  staticField.addChild(auxShape);
  //---------------------------------
  if(renderSea){
    auxShape = createShape();
    auxShape.beginShape(TRIANGLE_STRIP);
    
    for(int i=0; i<seaField.length - detail; i++){
      if(i%detail == 0){
        auxShape.endShape();
        staticField.addChild(auxShape);
        auxShape = createShape();
        auxShape.beginShape(TRIANGLE_STRIP);
      }
      fill(color(#5580ff, 160));
      PVector p = seaField[i];
      PVector p2 = seaField[i + detail];
      auxShape.vertex(p.x, p.y, p.z);
      auxShape.vertex(p2.x, p2.y, p2.z);
      
    }
    auxShape.endShape();
    staticField.addChild(auxShape);
  }
  
  
  return staticField;

}

void setup(){
  size(800,800,P3D);
  //camera settings
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(0);
  cam.setMaximumDistance(1000);
  cam.setDistance(600);
  frameRate(60);
  initialDisplacementFromOriginX =random(314.1592);
  initialDisplacementFromOriginY =random(314.1592);
  //initialize field
  det = 256;
  initTerrain(det);
  //set the points height's using perlin noise
  alterHeights();
  
  //correct color palette 
  //if(seaSmooth)
  //  seaLevel = minimumHeight + (float)heightestPoint/10.0;
  //else
  seaLevel = minimumHeight + (float)heightestPoint/6.0;
  
    
  //print creation details
  printLog();
 
}

void draw(){
  
  background(0);
  push();
    textSize(27);
    noStroke();
    fill(#ffffff);
    text(frameRate, width/5, -height/4, 0);
  pop();
  
  translate(- width/2.1 ,-300, -height);
  rotateX(PI/5);
  //yOffset -= 0.1;
 
  keyBoardControl();
  
  if(renderLightAndShadows){
    renderLightsAndShadows();
  }
  if(sf == null){
    alterHeights();
    renderField();
    if(renderSea){
       alterHeightsSea();
       renderSeaField();
    }
  }
  else  
  
    shape(sf);
}
