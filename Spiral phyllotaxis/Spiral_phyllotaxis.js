/*
Example of Spiral phyllotaxis
Author: Lia Belda 
see also: https://www.princeton.edu/~akosmrlj/MAE545_S2017/lecture12_slides.pdf
*/

//137.5 degrees

let angle = 0;
let offset = 0;
let slider;
let colors = 
    [{R: 255,G: 0, B: 0}, //red
     {R:253,G:143, B:27}, //orange
     {R:240,G:240, B:0}, //yellow
     {R:38,G:184, B:62}, //green
     {R:0,G:161, B:240}, //blue
     {R:29,G: 11, B:230}, //edgy blue
     {R:255,G:0, B:240}  //purple
    ];
function setup() {
  createCanvas(400, 400);
  slider = createSlider(0, 2*PI, 137.5%(2*PI),0.0015);
  slider.position(10, 10);
  slider.style('width', '80px');
}

function draw() {
  background(0);
  translate(width/2,height/2);
  angle=slider.value();
  for(let i = 1; i<600; i++){
    let r_,g_,b_;
    r_=colors[parseInt((offset/colors.length)%colors.length)].R,
    g_=colors[parseInt((offset/colors.length)%colors.length)].G,
    b_=colors[parseInt((offset/colors.length)%colors.length)].B
    
    stroke(r_,g_,b_);
    fill(r_,g_,b_);
    ellipse(offset,0,4,4);
    rotate(angle);
    offset+=0.30;
  }
  offset=0.15;
  //angle+=0.00015;
  j++;
  
}
