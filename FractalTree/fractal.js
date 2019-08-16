
var angle = 3.14159265359 / 4;
var slider;
function setup(){
  angleMode(DEGREES);
  createCanvas(1200,1200);
  slider = createSlider(40,120,360);
  
}
function draw(){
  background(51);
  stroke(255);
  angle =slider.value();
  translate(500,height);
  branch(angle*4);
}

function branch(len){
  line(0,0,0,-len);
  translate(0,-len);
  if (len>4){
    push();
    rotate(0);
    branch(len*0.50);
    pop();
    push();
    rotate(angle*1);
    branch(len*0.50);
    pop();
    push();
    rotate(-angle);
    branch(len*0.50);
    pop();
  }
}