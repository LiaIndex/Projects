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
float seaDisplacement;
float seaTime;
float initialDisplacementFromOriginX;
float initialDisplacementFromOriginY;
int maxHeight;
PeasyCam cam;
float heightestPoint;
float minimumHeight;
float seaLevel;
boolean renderSea;
boolean renderRivers;
boolean dynamicWater;
boolean renderWireFrame;
boolean dayMode;
boolean eveningMode;
boolean nightMode;
boolean renderLightAndShadows;
int det;
PShape sf;
char letra;

public color[] waterPalette =
    {//earth like
    #00429d,#1649a0,#2351a4,#2d58a7,#3660ab,#3e67ae,#456fb2,#4d77b5,#547fb8,#5b87bb,#618fbf,#6896c2,#6f9ec5,#77a6c8,#7eafcb,#85b7ce,#8dbfd1,#95c7d3,#9ecfd6,#a7d7d8,#b1dfdb,#bbe6dd
    };
public color[] surfacePalette =
    {//earth like
    #d1de45,#c9d93d,#c0d336,#b7cd2f,#adc628,#a2be21,#97b71a,#8baf13,#7fa60d,#729e07,#659403,#578b01,#488100,#437801,#487103,#4d6c06,#516609,#54620e,#585f12,#5c5c16,#605a1b,#645920,#685925,#6d5a2b,#725c31,#775e38,#7d623f,#836648,#896b51,#90725b,#977965,#9e8271,#a68c7e,#ad968c,#b5a29a,#bdafaa,#c5bebb,#cdcdcd};


/*
 * Special keys method
 * Corresponds to the adding/substracting level of detail 
 * and also the static creation of the field.
*/
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

/*
 * Key board control function, provides a method
 * to control the input of the user, sincerly 
 * i start to think that ive overkilled a bit
 * to many functions and keys, hard to remember all of them.
 * i should make this easier.
*/

void keyBoardControl(){
   letra = key;
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
      yOffsetSea -= seaDisplacement;
      break;
    case 'k':
      yOffsetSea += seaDisplacement;
      break;
    case 'j':
      xOffsetSea -= seaDisplacement;
      break;
    case 'l':
      xOffsetSea += seaDisplacement;
      break;
    case 'u':
      seaDisplacement += 0.0125;
      break;
    case 'o':
      seaDisplacement -= 0.0125;
      if(seaDisplacement < 0) seaDisplacement = 0.0125;
      break;
    case 't':
      dynamicWater = true;
      break;
    case 'y':
      dynamicWater = false;
      break;
    case 'r':
      renderRivers = true;
      break;
    case 'f':
      renderRivers = false;
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

/*
 * Typical print method to ckeck everything is going okay
 * and to show the list of commands.
*/

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
    "Dynamic water: "+ dynamicWater +"\n" +
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
      "u,o, increase/reduce the wind force\n"+
      "i,j,k,l, set the wind direction, similar to wasd\n"+
      "t,y, on/off dynamic water\n"+
      "r,f on/off render rivers (need improvement)\n"+
      "+,- add/substract detail\n"+
      "+++++++++++++++++++++++++++++++++++\n\n"
    
    );

}

/*
 * some variables such as if the water is moving, or if there is the 
 * need of rendering the wires, or the day modes have to be initialized
 * somewhere.
*/

void preinit(){
  dynamicWater = true;
  //seaSmooth = false;
  renderWireFrame = false;
  renderLightAndShadows = true;
  renderSea = true;
  dayMode = true;
  eveningMode = false;
  nightMode = false;
  renderRivers = false;
}

/*
 * Initialization method for the terrain, the sea,
 * the stars and the noise parameters.
*/

void initTerrain(int d){

  detail = d;
  field = new PVector[detail * detail];
  seaField = new PVector[detail * detail];
  xOffset = 0;
  yOffset = 0;
  xOffsetSea = 0;
  yOffsetSea = 0;
  maxHeight = 250;
  displacement = 0.0125;
  seaDisplacement = 0.0125;
  seaTime = 0.0125;
  heightestPoint = 0;
  minimumHeight = 999;
  
  
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

//not fully implemented neew improvement
boolean riverDepth(PVector p){
  
  //first get a four and eight octaves noise near to the terrain noise (near in the 3rd dimension time)
  noiseDetail(8, 0.45);
  float eightOctavesNoise = noise(
        p.x * noiseScale + xOffset + initialDisplacementFromOriginX,
        p.y * noiseScale + yOffset + initialDisplacementFromOriginY
      );
  noiseDetail(4, 0.45);
  float fourOctavesNoise = noise(
        p.x * noiseScale + xOffset + initialDisplacementFromOriginX,
        p.y * noiseScale + yOffset + initialDisplacementFromOriginY
      );
 
 /*
  * Extracted from what the main terrain generation function was,
  * this new method provides complex rivers without the previous
  * distortion from the mountain's slope. It is pleasantly good.
  * It could be better though.
 */
 
  float mask = eightOctavesNoise * -2.0 + 1.0;
  mask = abs ( (sin ( TWO_PI * mask) ) );
  float mask2 =(mask * 0.35 + fourOctavesNoise * 0.65  );
  
 /*
  * The noise threshold selected was 0.25, take into account 
  * that modifying the pondered sum below (incrementing the 
  * four octaves noise weight) will make the rivers thicker
  * and reducing it slimers.
 */
  return ( (mask < 0.25 || mask2 < 0.2) && p.z < (heightestPoint * 0.8) );
  
  /*
   * TODO for the future:
   * this function uses almost the same equations than the main terrain
   * does. It must be possible to optimize this operation.
  */
}


/*
 * Here i tried to make a random walker, so that the places it goes
 * the terrain goes sunken a bit in order to make rivers, it gone 
 * terribly wrong, i will keep this function here, buried from everyone,
 * just in case one day i wake up like "he, wait a second" and fix it 
 * and the birds sings happy songs all day, while god spread glitter 
 * over my galaxy brain. Probably never but idk.
*/

//prueba para rios, buggy
void prueba(){

print("iniciando\n");
int numeroDeRios = 100;
int alturaBuscada =150;

ArrayList<Integer> puntosConAgua = new ArrayList();
for(int i=0; i<field.length; i++){
 if(field[i].z <= seaLevel+1){
   puntosConAgua.add(i);  
   //print("punto con agua, altura:  "+field[i].z);
 }
}
print("encontrados "+puntosConAgua.size()+" puntos con agua\n");

for(int i=0; i< numeroDeRios; i++){
  int posicionInicial = (int) random(0,puntosConAgua.size());
  print("Empieza rio en : "+posicionInicial + "\n");
  //field[posicionInicial].z -= 20;
  float alturaActual = 0.0;
  
  while(alturaActual < alturaBuscada){
     alturaActual = field[posicionInicial].z;
    //print("indice de la posicion inicial: " + posicionInicial + " altura: "+alturaActual+"\n");
    float[] arr = {0,0,0,0};
    if(posicionInicial - 1 > 0)
       arr[0] = field[posicionInicial - 1].z;
    if(posicionInicial + 1 < field.length)
       arr[1] = field[posicionInicial + 1].z;
    if(posicionInicial - det > 0)
       arr[2] = field[posicionInicial - det].z;
    if(posicionInicial + det < field.length)
       arr[3] = field[posicionInicial + 1].z;
    float minimo = alturaActual;
    int indice = 0;
    //sacar vecino con mas altura
    //print("buscando siguiente punto \n");
    for(int j=0; j<arr.length; j++){
        if(arr[j] > minimo){
          minimo = arr[j];
          indice = j;
        }
    }
    switch(indice){
      case 0:
        field[posicionInicial - 1].z -= 5;
        posicionInicial --;
      break;
      case 1:
        field[posicionInicial + 1].z -= 5;
        posicionInicial ++;
      break;
      case 2:
        field[posicionInicial - det].z -= 5;
        posicionInicial -= det;
      break;
      case 3:
        field[posicionInicial + det].z -= 5;
        posicionInicial += det;
      break;
    }
     if(field[posicionInicial].z < minimumHeight) field[posicionInicial].z = minimumHeight;
     alturaActual = field[posicionInicial].z;
  }
}
print("fin");
}


/*
 * Main terrain function, call the noise algorithm
 * and applies it a modification to achieved more 
 * sophisticated and cool terrains, mpi, ridged, billowy...
 * It uses a very small scale and a low persistance, a bit controversial
 * values, the standart options are scales between 0.03 and 0.05 with
 * a persistance of 0.5.
*/

void alterHeights(){
  
  float noiseValue = 0.0;
  
  for(int i=0; i<field.length; i++){
   
    //for each point on the field get the four and eight octaves noise
    noiseDetail(8, 0.45);
    noiseScale = 0.0019;
    
    float h = 0;
    PVector p = field[i];
    float eightOctavesNoise = noise(
        p.x * noiseScale + xOffset + initialDisplacementFromOriginX,
        p.y * noiseScale + yOffset + initialDisplacementFromOriginY
      );
      
    noiseDetail(4, 0.45);
    noiseScale = 0.0019;
    
    float fourOctavesNoise = noise(
        p.x * noiseScale + xOffset + initialDisplacementFromOriginX,
        p.y * noiseScale + yOffset + initialDisplacementFromOriginY
      );
    
    //variables for the modifications
    float angle = eightOctavesNoise * TWO_PI;
    float mask = eightOctavesNoise*(-2.0) + 1;
    float billowyMask = abs(mask);
    float ridged = 1.0 - billowyMask;
    float sinNoiseValue = (1.0 - abs(sin(angle)));
    
    noiseValue = (sinNoiseValue * 0.55 + fourOctavesNoise * 0.45  ); // 2.0;      //bioma 1
    //noiseValue = max(sinNoiseValue, eightOctavesNoise)*0.9 + eightOctavesNoise*0.1;  //bioma 2 mas llanuras que otra cosa
    
    h = noiseValue * maxHeight ; //mpi mod
    //h = billowyMask * maxHeight;  //billowy mod, provisional rivers
    //h = ridged * maxHeight;       //rigid noise, typicall
    
    //if(renderRivers){
    //    if(riverDepth(p) > 0)
    //      h -= 4;
    //}
    //snow and sand references
    if(h > heightestPoint) heightestPoint = h;
    if(h < minimumHeight) minimumHeight = h;
    p.z = h;
  }
  
}

/*
 * Similar to the alterHeight but for the water,
 * this water system is to easy and at the same time to expensive,
 * im not pleased with it.
 */
void alterHeightsSea(){
  if(dynamicWater)
    seaTime += 0.05 ;
  noiseDetail(3, 0.5);
  float seaNoiseScale = 0.3;
  for(int i=0; i<seaField.length; i++){
   
    PVector p = seaField[i];
    float noiseValue = noise(
        p.x * seaNoiseScale + xOffsetSea ,
        p.y * seaNoiseScale + yOffsetSea ,
        seaTime
      );
    p.z = 2 * noiseValue + seaLevel ;
  }
  
  noiseDetail(8, 0.45);
}
/*
 * Altered Fibonacci sphere method 
*/

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

/*
 * Main shader method, pretty messy and complicated, 
 * i've definetly should change the lerpColor calls, or atleast
 * make them easier to read.
*/
color getColor(int i){
     //noiseDetail(2,0.5);
     color c = color(#000000);
     //float scale = 0.1;
      if((i+1)%detail !=0){
        
        //pilla la media de los puntos que forman este triangulo para sacar la diferencia de altura y saber como pintar
        float mean = (
                      field[i].z +
                      field[i+1].z + 
                      field[i+detail].z
                      )/3.0; //media de los vertices vecinos
                      
        //dividendoDePlanitud controla el nivel de detalle para que la vegetación no se lo coma todo
        float dividendoDePlanitud = (detail == 128) ? 1.0 : (float)(detail)/128.0 ;
        //variable que controla que tan plano tiene que ser el terreno para pintar vegetacion, roca, nieve o arena
        float constPlanitud = 1.6 / dividendoDePlanitud;
        //diferencia entre el punto evaluado y la media de sus vecinos
        float diferencia = abs(field[i].z - mean);
        
        color roca = lerpColor(#493829, #613318, 0.5);//lerpColor(#584030, lerpColor(#58473c, #4a3b32, 0.5) , diferencia);
        if( diferencia < constPlanitud){ //que tan plano es
          //c = color(#008f39);
          color veg = lerpColor(#404f24,#242c14, 1.1*diferencia/constPlanitud);
          c = lerpColor( veg, roca, field[i].z / (maxHeight*1.45)); //mix between rock and veg
        }
        else{//rocas y arena
          color sand = lerpColor(#1f3209,#435026, diferencia);
          c = lerpColor(roca, sand, 0.05); 
        }
        if(field[i].z >= ( 192 - (192 * 0.1) * noise(field[i].x * 0.0019+ xOffset + initialDisplacementFromOriginX, field[i].y * 0.0019 + yOffset + initialDisplacementFromOriginY) ) )
        { //nieve
            color paleSnow = #a9a19c;
            constPlanitud = 1.2 / dividendoDePlanitud;  //0.45
            if(diferencia < constPlanitud) //nieve
              c = lerpColor( roca, paleSnow, 0.8);
        }
        if(field[i].z <= seaLevel + (minimumHeight * 0.25) * noise(field[i].x * noiseScale, field[i].y * noiseScale) && renderSea ){ //arena, 40 es un numero arbitrario
              constPlanitud = 0.8 /dividendoDePlanitud;
              if(diferencia < constPlanitud) //borde arena
              {
                  color arena = lerpColor(#f8c876, roca ,0.7);
                  color auxVeg = lerpColor(#404f24,#242c14, diferencia/constPlanitud);
                  c = lerpColor(arena, auxVeg, diferencia / 2);
              }
        }
        if(renderRivers){
          if(riverDepth(field[i])){
            c = lerpColor(#002780, #4E6172, 0.5);   
          }
        }//render rivers
      }
      return c;
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
    
    
    //zona agua
    color c;
    if(renderSea){
      if(field[i].z <= seaLevel){
        //under sea level use water palette
        c = waterPalette[ (int)map(field[i].z, minimumHeight, seaLevel, 0, waterPalette.length - 1)]; 
      //zona tierra
      }else{  
       c  = getColor(i);
      }
    }else{
      c  = getColor(i);
    }
    
    if(renderWireFrame) c = color(#ffffff);
    fill(c);
    PVector p = field[i];
    PVector p2 = field[i + detail];
    vertex(p.x, p.y, p.z);
    vertex(p2.x, p2.y, p2.z);
    
  }
  endShape();
  noiseDetail(8, 0.45);
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
    else{
      fill(color(lerpColor(#002780,#ffffff, ((seaField[i].z-seaLevel)/15.0)), 180));
    }
    PVector p = seaField[i];
    PVector p2 = seaField[i + detail];
    vertex(p.x, p.y, p.z);
    vertex(p2.x, p2.y, p2.z);
    
  }
  endShape();
}




void renderStars(){
  push();
  translate(width/2, height/2);
  stroke(255);
    for(int i=0; i<stars.length; i++){
      strokeWeight(random(1,2));
      point(stars[i].x,stars[i].y,stars[i].z);
   }
  noStroke();
  pop();
}

void renderLightsAndShadows(){
  float xCamPosNorm = map(mouseX, 0, width, 1, -1);
  float yCamPosNorm = map(mouseY, 0, height, 1, -1);
  float zCamPosNorm = -0.59;
  //print("mouseX : "+mouseX+"\nmouseY: "+mouseY+"\n");
  
  if(dayMode){
    directionalLight(255, 242, 231, xCamPosNorm, yCamPosNorm, zCamPosNorm);
  }
  else if(nightMode){
    directionalLight(133, 118, 175, xCamPosNorm, yCamPosNorm, zCamPosNorm);
    renderStars();
  }else if(eveningMode){
    directionalLight(255, 213, 128, xCamPosNorm, yCamPosNorm, zCamPosNorm);
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
    
    //zona agua
    color c;
    if(renderSea){
      if(field[i].z <= seaLevel){
        //under sea level use water palette
        c = waterPalette[ (int)map(field[i].z, minimumHeight, seaLevel, 0, waterPalette.length - 1)];
        
     //zona tierra
      }else{
        c = getColor(i);
      }//if > seaLevel, es decir si pintamos tierra
    }else{
      c = getColor(i);
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
  /*if(renderSea){
    auxShape = createShape();
    auxShape.beginShape(TRIANGLE_STRIP);
    
    for(int i=0; i<seaField.length - detail; i++){
      if(i%detail == 0){
        auxShape.endShape();
        staticField.addChild(auxShape);
        auxShape = createShape();
        auxShape.beginShape(TRIANGLE_STRIP);
      }
      if(field[i].z > seaLevel + 1)
        auxShape.fill(color(#5580ff, 0));
      else
        auxShape.fill(color(#5580ff, 160));
      
      PVector p = seaField[i];
      PVector p2 = seaField[i + detail];
      auxShape.vertex(p.x, p.y, p.z);
      auxShape.vertex(p2.x, p2.y, p2.z);
      
    }
    auxShape.endShape();
    staticField.addChild(auxShape);
  }*/
  
  return staticField;

}

void setup(){
  size(1024,1024,P3D);
  //camera settings
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(0);
  cam.setMaximumDistance(3000);
  cam.setDistance(600);
  frameRate(100);
  initialDisplacementFromOriginX =random(314.1592);
  initialDisplacementFromOriginY =random(314.1592);
  //initialize field
  det = 256;
  preinit();
  initTerrain(det);
  //set the points height's using perlin noise
  alterHeights();
  
  //correct color palette 
  //if(seaSmooth)
  //  seaLevel = minimumHeight + (float)heightestPoint/10.0;
  //else
  seaLevel = minimumHeight + (float)heightestPoint/11.0;
  
    
  //print creation details
  printLog();
 
}

void draw(){
  
  background(0);
  push();
    textSize(14);
    noStroke();
    fill(#ffffff);
    text(frameRate+"\n"
         +detail*detail+
         "\nxOffset: "+xOffset+
         "\nyOffset: "+yOffset, 
         width/5, -height/4, 0);
  pop();
  
  translate(- width/2.1 ,-300, -height);
  rotateX(PI/5);
  //yOffset -= 0.1;
 
  keyBoardControl();
  
  if(renderLightAndShadows){
    renderLightsAndShadows();
  }
  if(sf == null){
    if(letra=='w' || letra=='a' || letra=='s' || letra=='d' || letra=='q' ||
    letra=='e' || letra=='z' || letra=='c')
      alterHeights();
    renderField();
    if(renderSea){
       alterHeightsSea();
       renderSeaField();
    }
  }
  else{
    shape(sf);
    if(renderSea){
      alterHeightsSea();
      renderSeaField();
    }
  }
}
