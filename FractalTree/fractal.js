/*
example of recursion with pop and push
using P5 library for JavaScript
*/


var angle;
var slider;
function setup(){
   angle = PI / 4;
  angleMode(DEGREES);
  createCanvas(600,600);
  slider = createSlider(40,120,360);
  
}
function draw(){
  background(51);
  stroke(255);
  angle =slider.value();
  translate(width/2,height);
  branch(angle*2);
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
