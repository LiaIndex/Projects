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



void setup(){
  
  PImage sun_img = loadImage("sun.jpg");
  PImage mercury_img = loadImage("mercury.jpg");
  PImage venus_img = loadImage("venus.jpg");
  PImage earth_img = loadImage("earth.jpg");
  PImage mars_img = loadImage("mars.jpg");
  PImage jupiter_img = loadImage("jupiter.jpg");
  PImage saturn_img = loadImage("saturn.jpg");
  PImage uranus_img = loadImage("uranus.jpg");
  PImage neptune_img = loadImage("neptune.jpg");
  
  mercury = new celestial_body(8, 150, 30, 0, "mercury", null, mercury_img);
  venus = new celestial_body(5, 200, 30, 0, "venus", null, venus_img);
  earth = new celestial_body(10, 250, 30, 0, "earth planet", new ArrayList<celestial_body>(), earth_img);
  moon = new celestial_body(3, 16, 2, 0, "earth_moon", null, null);
  moon2 = new celestial_body(3, 32, 2, 0, "earth_moon", null,  null);
  earth.childrens.add(moon);
  //earth.childrens.add(moon2);
  mars = new celestial_body(10, 300, 30, 0, "mars", null, mars_img);
  jupiter = new celestial_body(40, 500, 30, 0, "jupiter", null, jupiter_img);
  saturn = new celestial_body(30, 600, 30, 0, "venus", null, saturn_img);
  uranus = new celestial_body(15, 700, 30, 0, "mars", null, uranus_img);
  neptune = new celestial_body(10, 800, 30, 0, "jupiter", null, neptune_img);
  //sun = new celestial_body(50, 0, 1, 0, "sun", 1, 0);
  
  
  
  sun = new celestial_body(100, 0, 2, 0, "sun", new ArrayList<celestial_body>(), sun_img);
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
}
void draw(){
  
  background(0);
  push();
  translate(width/2, height/2);
  lights();
  pop();
  sun.show();
  
  for(int i=0; i<sun.childrens.size(); i++){
    sun.childrens.get(i).show_orbit();
  }
}
