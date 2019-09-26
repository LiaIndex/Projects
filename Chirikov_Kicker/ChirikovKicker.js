/*
Example of Chirikov_Kicker using p5 for JS
Author: Lia de Belda
see also:
  https://www.complexity-explorables.org/
*/

//chaotic variable
let k = 0.5;
//orbits
let origins = [];
//on true show p, x, k
let debug = false;

function setup() {
  
  createCanvas(400, 400);
  
  slider = createSlider(0, 20, 5);
  slider.position(10, 0);
  slider.style('width', '80px');
  
  //set orbits
  for(let i=0; i<250; i++){
    x=parseInt(random(width));
    p=parseInt(random(height));
    //origins.push({x:x, p:p});
    origins.push({x:x, p:p});
  }
}

function mouseClicked() {
  let mx = mouseX%(2*PI);
  let my = mouseY%(2*PI)
  console.log(mx, my);
  origins.push({x:mx,p:my});  
}

function draw() {
  //background(220);
  
  //on new K reset canvas
  for(let j=0; j<origins.length; j++){
    
    if(k!=slider.value()/10){
      background(220);
      k = slider.value()/10;
    }
    
    let p=origins[j].p;
    let x=origins[j].x;
    
    //iterate functions
    let p_= (p + ( k * sin(x) ) )%(4*PI);
    let x_ = (x + p_)%(4*PI);
  
    //map Values
    let mp = map(p_, 0, (2*PI), 0, width);
    let mx = map(x_, 0, (2*PI), 0, height);
  
    //update value
    
    origins[j].p = p_;
    origins[j].x = x_;
    
    stroke(0);
    ellipse(mx,mp,2,2);
    
  
    if(debug){
      noStroke();
      rect(0,0,160,75);
      stroke(0);
      text(
        'p_: '+p_+"\n"
        +"x_: "+x_+"\n"+
        "k: "+k+"\n", 
        10, 30
      );
    }
    
  }
}
