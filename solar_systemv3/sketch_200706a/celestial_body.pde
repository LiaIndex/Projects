class celestial_body {

    float radius;
    float orbital_distance;
    float mass;
    ArrayList < celestial_body > childrens = null;
    String name;
    PVector p;
    PVector a; //acceleration
    PVector v; //velocity

    ArrayList < point_ > history;
    PShape globe;
    PShape disk;
    Boolean debug = true;

    //procedural 
    int detail = 0;
    PVector[][] sphere;
    color[] palette;
    float orbital_angle = 0; //simulates planet rotation 
    palette_color pal_o = new palette_color();


    celestial_body(float r, float o, float m, String n, ArrayList < celestial_body > c, PImage texture2, int levelOfDetail, PVector vel) {
        radius = r; //radius of the celestial body
        orbital_distance = o; //distance to the celestial body wich this is orbiting
        mass = m; //mass of the celestial body
        childrens = c; //arraylist of celestial bodys
        name = n; //name of the celestial body
        p = PVector.random3D().mult(o); //point in r3
        v = vel.mult(6);
        a = new PVector(0, 0, 0);
        history = new ArrayList < point_ > (); //of the points in space wich this object has been
        detail = levelOfDetail;
        sphere = calculateSpherePoints(detail, (int) r, (int) r + 10);
        if (texture2 != null) {
            disk = createShape(ELLIPSE, 0, 0, radius * 4, radius * 4);
            disk.setTexture(texture2);
        }
        palette = pal_o.getPaletteByName(name);
    }


    //update x,y,z position based on velocityu and acceleration
    void update() {
        this.v.add(this.a);
        this.p.add(this.v);
    }
    //set the acceleration to the given force  
    void applyForce(PVector dir) {
        PVector f = PVector.div(dir, this.mass);
        this.a = f;
    }
    //"atracts" another celestial body to the current x,y,z location based on F=(m1*m2)/(r^2)  
    void atract(celestial_body body) {
        PVector dir = PVector.sub(this.p, body.p);
        float distance = constrain(dir.magSq(), 100, 1000); //TODO: improve constrains
        if (dir.magSq() != 0) {
            float strength = (this.mass * body.mass) * 8 / distance;
            dir.setMag(strength);
            body.applyForce(dir);
        }
    }


    /**
     * calculates the x,y,z coordinates for every point of a sphere
     * the points will be stored in a 2 dimensional array (glob) 
     * with dimensions lvlOfDetail x lvlOfDetail
     * each point can have a distance to his origin between radius and radiusM
     **/

    PVector[][] calculateSpherePoints(int lvlOfDetail, int radius, int radiusM) {

        PVector[][] glob = new PVector[lvlOfDetail][lvlOfDetail];
        float scl = map(radius, 5, 100, 1, 5); //controls the excentricity of the noise

        for (int i = 0; i < lvlOfDetail; i++) {
            float theta = map(i, 0, lvlOfDetail - 1, -PI, PI);
            if (i == 0 || i == lvlOfDetail - 1) theta += TWO_PI / lvlOfDetail; //edge case control
            for (int j = 0; j < lvlOfDetail; j++) {
                float phi = map(j, 0, lvlOfDetail - 1, -HALF_PI, HALF_PI);
                if (j == 0 || j == lvlOfDetail - 1) phi += TWO_PI / lvlOfDetail; //edge case control
                float rad = map(
                    noise(
                        sin(theta) * cos(phi) * scl + radius,
                        sin(theta) * sin(phi) * scl + radius,
                        cos(theta) * scl + radius
                    ), 0, 1, radius, radiusM
                );
                float x = rad * sin(theta) * cos(phi);
                float y = rad * sin(theta) * sin(phi);
                float z = rad * cos(theta);

                glob[i][j] = new PVector(x, y, z);

            }
        }
        return glob;
    }

    /**
     *
     *  Depending on the celestial_body "show" will draw the sphere 
     *  with the draw_glob function, after calling calculateSpherePoints
     *  draw the disk of the celestial_body, call the show function for the
     *  celestial_bodys orbiting this celestial_body, also this function
     *  will store the trace history of the planet to show the orbit and control 
     *  the angle pf rotation.
     **/

    void show() {
        pushMatrix();
        if (debug) line(0, 0, 0, p.x, p.y, p.z);

        translate(p.x, p.y, p.z);
        if (childrens != null) {
            for (int i = 0; i < childrens.size(); i++) {
                celestial_body child = childrens.get(i);
                stroke(230, 140);
                child.show();
            }
        }

        if (debug) {
            stroke(color(255, 0, 0));
            line(0, 0, 0, radius * 2, 0, 0);
            stroke(color(0, 255, 0));
            line(0, 0, 0, 0, radius * 2, 0);
            stroke(color(0, 0, 255));
            line(0, 0, 0, 0, 0, radius * 2);
        }

        rotateY(orbital_angle);
        noStroke();

        if (disk != null) {
            shape(disk);
            //TODO improve disks
        }
        if (this.detail != 0) {
            draw_glob(sphere);
        } else {
            shape(globe);
        }


        float x = modelX(0, 0, 0);
        float y = modelY(0, 0, 0);
        float z = modelZ(0, 0, 0);

        history.add(new point_(x, y, z));
        if (history.size() > 50) history.remove(0);

        popMatrix();
        orbital_angle += 0.01;

    }

    void show_orbit() {
        stroke(255);
        for (int i = 1; i < history.size(); i++) {
            stroke(i % 255);
            line(history.get(i).x, history.get(i).y, history.get(i).z,
                history.get(i - 1).x, history.get(i - 1).y, history.get(i - 1).z);
        }
        if (childrens != null) {
            for (int j = 0; j < childrens.size(); j++) {
                childrens.get(j).show_orbit();
            }
        }
    }

    /**
     *  Draws the sphere shape based on calculateSpherePoints function
     *  with a triangular mesh.
     **/

    void draw_glob(PVector[][] points) {
        for (int i = 0; i < points.length; i++) {
            for (int j = 0; j < points[i].length; j++) {

                PVector p = points[i][j];
                //triangular mesh
                float mean = p.mag();
                int divs = 1;
                beginShape(TRIANGLES);
                vertex(p.x, p.y, p.z);
                if (i + 1 < points.length) { //&& j+1 >= points[i].length){
                    PVector p2 = points[i + 1][j];
                    vertex(p2.x, p2.y, p2.z);
                    mean += p2.mag();
                    divs++;
                }
                if (j + 1 < points[i].length) { //&& i+1 >= points[i].length){
                    PVector p3 = points[i][j + 1];
                    vertex(p3.x, p3.y, p3.z);
                    vertex(p3.x, p3.y, p3.z);
                    mean += p3.mag();
                    divs++;
                }
                if (i + 1 < points.length) { //&& j+1 >= points[i].length){
                    PVector p2 = points[i + 1][j];
                    vertex(p2.x, p2.y, p2.z);
                    mean += p2.mag();
                    divs++;
                }
                if (i + 1 < points.length && j + 1 < points[i].length) {
                    PVector p4 = points[i + 1][j + 1];
                    vertex(p4.x, p4.y, p4.z);
                    mean += p4.mag();
                    divs++;
                }

                mean /= (float) divs;

                fill(calculateColor(mean));
                endShape();
            }
        }
    }


    color calculateColor(float mean) {
        return palette[(int) map(mean, radius, radius + 10, 0, palette.length - 1)];
    }

}


class point_ {
    float x;
    float y;
    float z;
    point_(float x_, float y_, float z_) {
        x = x_;
        y = y_;
        z = z_;
    }
}
