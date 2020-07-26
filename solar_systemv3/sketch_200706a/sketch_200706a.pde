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

void setup() {

    PImage saturn_disk = loadImage("saturn_disk.jpg");
    PImage uranus_disk = loadImage("uranus_disk2.jpg");

    mercury = new celestial_body(
        5, //radius of the planet
        200, //initial distance from the star
        20, //units of mass

        "mercury", //name
        null, //childrens
        null, //texture for disk
        30, //lvl of detail
        new PVector(5, 0, 0) //initial velocity
    );
    venus = new celestial_body(7, 250, 25, "venus", null, null, 30, new PVector(5, 0, 0));
    earth = new celestial_body(10, 500, 100, "earth_planet", new ArrayList < celestial_body > (), null, 50, new PVector(5, 0, 0));
    moon = new celestial_body(2, 10, 20, "earth_moon", null, null, 20, new PVector(0, 0, 0));
    //moon2 = new celestial_body(3, 32, 2, 0, "earth_moon", null,  null, 30);
    earth.childrens.add(moon);
    //earth.childrens.add(moon2);
    mars = new celestial_body(10, 580, 28, "mars", null, null, 30, new PVector(5, 0, 0));
    jupiter = new celestial_body(50, 650, 90, "jupiter", null, null, 60, PVector.random3D().mult(10));
    saturn = new celestial_body(35, 780, 80, "saturn", null, saturn_disk, 50, PVector.random3D().mult(10));
    uranus = new celestial_body(10, 840, 30, "uranus", null, uranus_disk, 30, PVector.random3D().mult(10));
    neptune = new celestial_body(15, 900, 50, "neptune", null, null, 30, PVector.random3D().mult(10));

    sun = new celestial_body(100, 0, 300, "sun", new ArrayList < celestial_body > (), null, 120, new PVector(0, 0, 0));
    sun.childrens.add(mercury);
    sun.childrens.add(venus);
    sun.childrens.add(earth);
    sun.childrens.add(mars);
    sun.childrens.add(jupiter);
    sun.childrens.add(saturn);
    sun.childrens.add(uranus);
    sun.childrens.add(neptune);



    size(800, 800, P3D);
    cam = new PeasyCam(this, 100);
    cam.setMinimumDistance(500);
    cam.setMaximumDistance(3000);
    bg = loadImage("star.png");
}
void draw() {

    background(bg);

    spotLight(180, 180, 180, 0, 0, 500, 0, 0, -1, PI, 2);
    spotLight(180, 180, 180, 0, 500, 0, 0, -1, 0, PI, 2);
    spotLight(180, 180, 180, 500, 0, 0, -1, 0, 0, PI, 2);

    spotLight(180, 180, 180, 0, 0, -500, 0, 0, 1, PI, 2);
    spotLight(180, 180, 180, 0, -500, 0, 0, 1, 0, PI, 2);
    spotLight(180, 180, 180, -500, 0, 0, 1, 0, 0, PI, 2);


    sun.show();

    for (int i = 0; i < sun.childrens.size(); i++) {
        celestial_body cb = sun.childrens.get(i);
        cb.show_orbit();
        sun.atract(cb);
        cb.update();

    }


}
