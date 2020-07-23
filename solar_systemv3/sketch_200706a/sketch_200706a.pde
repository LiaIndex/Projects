import peasy.*;
PeasyCam cam;

celestial_body sun;
celestial_body sun2;

celestial_body moon;
celestial_body moon2;

celestial_body earth;
celestial_body mercury;
celestial_body venus;

celestial_body mars;
celestial_body jupiter;
celestial_body saturn;
celestial_body uranus;
celestial_body neptune;

celestial_body saturn_d1;
celestial_body saturn_d2;
celestial_body saturn_d3;
celestial_body saturn_d4;

PImage bg;

void setup(){
  
  PImage saturn_disk = loadImage("saturn_disk.jpg");
  PImage uranus_disk = loadImage("uranus_disk2.jpg");
  
  mercury = new celestial_body(5, 150, 30, 0, "mercury", null, null, 30);
  venus = new celestial_body(7, 230, 30, 0, "venus", null, null, 30);
  earth = new celestial_body(10, 275, 30, 0, "earth_planet", new ArrayList<celestial_body>(), null, 50);
  moon = new celestial_body(2, 30, 2, 15, "earth_moon", null, null, 20);
  //moon2 = new celestial_body(3, 32, 2, 0, "earth_moon", null,  null, 30);
  earth.childrens.add(moon);
  //earth.childrens.add(moon2);
  mars = new celestial_body(10, 320, 30, HALF_PI, "mars", null, null, 30);
  jupiter = new celestial_body(50, 500, 30, 0, "jupiter", null, null, 90);
  saturn = new celestial_body(35, 600, 30, 0, "saturn",null, saturn_disk,70);
  uranus = new celestial_body(10, 700, 30, 0, "uranus", null, uranus_disk,30);
  neptune = new celestial_body(15, 800, 30, 0, "neptune", null, null,30);
  
  sun = new celestial_body(100, 0, 2, 0, "sun", new ArrayList<celestial_body>(), null,120);
  sun.childrens.add(mercury);
  sun.childrens.add(venus);
  sun.childrens.add(earth);
  sun.childrens.add(mars);
  sun.childrens.add(jupiter);
  sun.childrens.add(saturn);
  sun.childrens.add(uranus);
  sun.childrens.add(neptune);
  
  
  
  size(800,800, P3D);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(500);
  cam.setMaximumDistance(2000);
  bg = loadImage("star.png");
}
void draw(){
  
  background(bg);
  
    spotLight(180,180,180,0,0,500,0,0,-1, PI,2);
    spotLight(180,180,180,0,500,0,0,-1,0, PI,2);
    spotLight(180,180,180,500,0,0,-1,0,0, PI,2);
    
    spotLight(180,180,180,0,0,-500,0,0,1, PI,2);
    spotLight(180,180,180,0,-500,0,0,1,0, PI,2);
    spotLight(180,180,180,-500,0,0,1,0,0, PI,2);
    

  sun.show();

  for(int i=0; i<sun.childrens.size(); i++){
    sun.childrens.get(i).show_orbit();
  }
}
