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
  
  celestial_body(float r, float o, float m, float a, String n, ArrayList<celestial_body> c, PImage texture){
    radius = r;
    orbital_distance = o;
    mass = m;
    orbital_angle = a;
    name = n;
    p = PVector.random3D().mult(o);
    childrens = c;
    history = new ArrayList<point_>();
    noStroke();
    globe = createShape(SPHERE, radius);
    if(texture != null){
      globe.setTexture(texture);
    }  
 }
  
  
  void show(){
    pushMatrix();

    PVector p_ = new PVector(
                        /*(int)random(-1,1),
                        (int)random(-1,1),
                        (int)random(-1,1)*/
                        
                        -1,-1,-1
                       );
    PVector cross = p.cross(p_);
        
        rotate(orbital_angle,cross.x,cross.y,cross.z);
        //history.add(p);
        line(0,0,0 ,p.x,p.y,p.z);
       
        translate(p.x,p.y,p.z);
        
        if(childrens != null) {
        for(int i=0; i<childrens.size(); i++){
          celestial_body child = childrens.get(i);
          stroke(230,140);
          child.show();
          }
        }
     
         
      stroke(color(255,0,0));
      line(0,0,0, radius*2,0,0);
      stroke(color(0,255,0));
      line(0,0,0, 0,radius*2,0);
      stroke(color(0,0,255));
      line(0,0,0, 0,0,radius*2);
      
      noStroke();
    
      rotateZ(orbital_angle); 
      shape(globe);
      
      
      float x = modelX(0,0,0);
      float y = modelY(0,0,0);
      float z = modelZ(0,0,0);
      history.add(new point_(x,y,z));
      if(history.size() > 800 )history.remove(0);
      
    popMatrix();
    
    orbital_angle += 0.01;
  }
  
  void show_orbit(){
    stroke(255);
    for(int i=0; i<history.size(); i++){
       point(history.get(i).x, history.get(i).y, history.get(i).z);
    }
    if(childrens!=null){
      for(int j=0; j<childrens.size(); j++){
        childrens.get(j).show_orbit();
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
