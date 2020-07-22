class celestial_body{

  float radius;
  float orbital_distance;
  float mass;
  float orbital_angle;
  ArrayList<celestial_body> childrens = null;
  String name;
  int level;
  PVector p;
  ArrayList<point_> history;
  PShape globe;
  PShape disk;
  Boolean debug = false;
  //procedural 
   int detail = 30;
  PVector[][] sphere;
  float[][] noiseV;
  
  //deprecated
  celestial_body(float r, float o, float m, float a, String n, int c, int l){
    radius = r;
    orbital_distance = o;
    mass = m;
    orbital_angle = a;
    name = n;
    level = l;
    p = PVector.random3D().mult(o);
    
    if(c > 0){
      childrens = new ArrayList<celestial_body>();
      for(int i=0; i<c; i++){
        
        celestial_body cb = new celestial_body(
                                  radius / 3,
                                  (radius + random(50,200))/(level+1),
                                  random(1,3),
                                  random(TWO_PI),
                                  "SS"+i,
                                  (level < 1? 1 : 0),
                                  level + 1
                            );
        childrens.add(cb);
      }
    }
  }
  //use this
  celestial_body(float r, float o, float m, float a, String n, ArrayList<celestial_body> c, PImage texture, PImage texture2){
    radius = r; //radius of the celestial body
    orbital_distance = o; //distance to the celestial body wich this is orbiting
    mass = m; //mass of the celestial body
    orbital_angle = a; //angle 0 - TWO_PI
    name = n; //name of the celestial body
    p = PVector.random3D().mult(o); //point in r3
    childrens = c; //arraylist of celestial bodys
    history = new ArrayList<point_>(); //of the points in space wich this object has been
    noStroke();
    
    if(this.name.equals("earth_planet")){
      detail = 30;
      sphere = calculateSpherePoints(detail, (int)r, (int)r+10);
    }else if(this.name.equals("sun")){
      detail = 50;
      sphere = calculateSpherePoints(detail, (int)r, (int)r+10);
    }else{
      globe = createShape(SPHERE, radius);
      if(texture != null){
        globe.setTexture(texture);
      }
      if(texture2 != null){
        disk = createShape(ELLIPSE, 0,0,radius*4, radius*4);
        disk.setTexture(texture2);
      }
    }
 }
  
  
  void show(){
    pushMatrix();
    PVector p_ = new PVector(
                        /*(int)random(-1,1),
                        (int)random(-1,1),
                        (int)random(-1,1)*/
                        
                        1,0,1
                       );
    PVector cross = p.cross(p_); //position in space cross product arbitrary vector
        
        rotate(orbital_angle,cross.x,cross.y,cross.z);
        //history.add(p);
        if(debug) line(0,0,0 ,p.x,p.y,p.z);
       
        translate(p.x,p.y,p.z);
        
        if(childrens != null) {
        for(int i=0; i<childrens.size(); i++){
          celestial_body child = childrens.get(i);
          stroke(230,140);
          child.show();
          }
        }
     
      if(debug){  
        stroke(color(255,0,0));
        line(0,0,0, radius*2,0,0);
        stroke(color(0,255,0));
        line(0,0,0, 0,radius*2,0);
        stroke(color(0,0,255));
        line(0,0,0, 0,0,radius*2);
      }
      //noStroke();
      if(name.equals("sun"))fill(255,0,0,0);
      rotateY(orbital_angle);
      noStroke();
      if(disk != null) shape(disk);
      if(this.name.equals("earth_planet") || this.name.equals("sun")){
        draw_glob(sphere);
      }
      else{shape(globe);}
      
      
      float x = modelX(0,0,0);
      float y = modelY(0,0,0);
      float z = modelZ(0,0,0);
      
      history.add(new point_(x,y,z));
      if(history.size() > 100 )history.remove(0);
      
    popMatrix(); 
    orbital_angle += 0.01; //TODO aply newtonian forces
  }
  
  void show_orbit(){
    stroke(255);
    for(int i=1; i<history.size(); i++){
      stroke(i%255);
       line(history.get(i).x, history.get(i).y, history.get(i).z,
           history.get(i-1).x, history.get(i-1).y, history.get(i-1).z);
    }
    if(childrens!=null){
      for(int j=0; j<childrens.size(); j++){
        childrens.get(j).show_orbit();
      }
    }
  }
   
PVector[][] calculateSpherePoints(int lvlOfDetail, int radius, int radiusM){

  PVector[][] glob = new PVector[lvlOfDetail][lvlOfDetail];
  float scl = 1.0; //controls the excentricity of the noise
  
  for(int i=0; i<lvlOfDetail; i++){
    float theta = map(i, 0, lvlOfDetail - 1, -PI, PI);
    if(i==0 || i==lvlOfDetail-1)theta += TWO_PI/lvlOfDetail; //edge case control
    for(int j=0; j<lvlOfDetail; j++){
      float phi = map(j, 0, lvlOfDetail - 1, -HALF_PI, HALF_PI);
      if(j==0|| j==lvlOfDetail-1)phi += TWO_PI/lvlOfDetail; //edge case control
          float rad = map (
                    noise(
                       sin(theta) * cos(phi) * scl +radius,
                       sin(theta) * sin(phi) * scl +radius,
                       cos(theta) * scl +radius 
                    ), 0, 1, radius, radiusM
                  );
       float x = rad * sin(theta) * cos(phi);
       float y = rad * sin(theta) * sin(phi);
       float z = rad * cos(theta);
       
       glob[i][j] = new PVector(x,y,z);
       
     }
  }
  return glob;
}


void draw_glob(PVector[][] points){
  for(int i=0; i<points.length; i++){
    for(int j=0; j<points[i].length; j++){
      
      PVector p = points[i][j];
      //triangular mesh
      float mean = p.mag();
      int divs = 1;
      beginShape(TRIANGLES);
      vertex(p.x,p.y,p.z);
        if( i+1 < points.length){ //&& j+1 >= points[i].length){
          PVector p2 = points[i+1][j];
          vertex(p2.x, p2.y, p2.z);
          mean += p2.mag();
          divs++;
        }
        if( j+1 < points[i].length){ //&& i+1 >= points[i].length){
          PVector p3 = points[i][j+1];
          vertex(p3.x, p3.y, p3.z);
          vertex(p3.x, p3.y, p3.z);
          mean += p3.mag();
          divs++;
        }
        if( i+1 < points.length){ //&& j+1 >= points[i].length){
          PVector p2 = points[i+1][j];
          vertex(p2.x, p2.y, p2.z);
          mean += p2.mag();
          divs++;
        }
        if(i+1 < points.length && j+1 < points[i].length){
          PVector p4 = points[i+1][j+1];
          vertex(p4.x, p4.y, p4.z);
          mean += p4.mag();
          divs++;
        }
        
       //TODO MAKE THE COLORS BE CHOOSEN ON A FUNCTION
      
      if(this.name.equals("sun")){
        mean /= (float)divs;
        if(mean - radius >= 0 && mean - radius < 2 ){
          float c1 = map(mean, radius, radius + 5, 255, 240);
          fill(color(c1, c1, 0),254);
        }
        else if(mean - radius >= 2 && mean - radius < 4){
          float c1 = map(mean, radius, radius + 5, 210, 240);
          fill(color(c1, c1, 0),254);
        }
        else if(mean - radius >= 4){
          fill(color(240,240,0),254);
        }
         
      }else{
          mean /= (float)divs;
        if(mean - radius >= 5 && mean - radius < 6 )
          fill(color(20, map(mean, radius, radius + 10, 240, 80)  ,20));
        else if(mean - radius >= 6 && mean - radius < 7)
          fill(color(map(mean, radius, radius + 10, 100, 80), 48,48));
        else if(mean - radius >= 7)
          fill(color(255,255,255));
        else
          fill(color(0, 0 ,map(mean, radius, radius + 10, 100, 240) ));
       }
      endShape();
    }
  }  
}


}

class point_{
  float x;
  float y;
  float z;
  point_(float x_, float y_, float z_){
    x = x_;
    y = y_;
    z = z_;
  }
}
