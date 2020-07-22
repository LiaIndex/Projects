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
  
  PImage sun_img = loadImage("sun.jpg");
  PImage mercury_img = loadImage("mercury.jpg");
  PImage venus_img = loadImage("venus.jpg");
  PImage earth_img = loadImage("earth.jpg");
  PImage mars_img = loadImage("mars.jpg");
  PImage jupiter_img = loadImage("jupiter.jpg");
  PImage saturn_img = loadImage("saturn.jpg");
  PImage uranus_img = loadImage("uranus.jpg");
  PImage neptune_img = loadImage("neptune.jpg");
  PImage saturn_disk = loadImage("saturn_disk.jpg");
  PImage uranus_disk = loadImage("uranus_disk2.jpg");
  
  mercury = new celestial_body(5, 210, 30, 0, "mercury", null, mercury_img, null);
  venus = new celestial_body(7, 230, 30, 0, "venus", null, venus_img, null);
  earth = new celestial_body(10, 275, 30, 0, "earth_planet", new ArrayList<celestial_body>(), earth_img, null);
  moon = new celestial_body(2, 30, 2, 15, "earth_moon", null, null, null);
  moon2 = new celestial_body(3, 32, 2, 0, "earth_moon", null,  null, null);
  earth.childrens.add(moon);
  //earth.childrens.add(moon2);
  mars = new celestial_body(10, 310, 30, 0, "mars", null, mars_img, null);
  jupiter = new celestial_body(50, 500, 30, 0, "jupiter", null, jupiter_img, null);
  saturn = new celestial_body(35, 600, 30, 0, "saturn",null, saturn_img, saturn_disk);
  uranus = new celestial_body(10, 700, 30, 0, "uranus", null, uranus_img, uranus_disk);
  neptune = new celestial_body(15, 800, 30, 0, "neptune", null, neptune_img, null);
  //sun = new celestial_body(50, 0, 1, 0, "sun", 1, 0);
  
  sun = new celestial_body(100, 0, 2, 0, "sun", new ArrayList<celestial_body>(), sun_img, null);
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
  //hint(ENABLE_DEPTH_TEST);
  //hint(ENABLE_DEPTH_SORT);
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
