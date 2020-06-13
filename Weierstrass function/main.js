/*
Representration of the Weierstrass function.
An interesting function represented as a fourier series
shows a fractal pattern, b goes up to 5, a stays in 0.5
*/

let a = 0.5;
let b = 0.1;
let ni=0;
let nj=0;
let flagup = true;
let flagdown = false;
let flag_animation = true;

function drawAxis(){
  stroke(0);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
  text('-3', 15, height/2);
  text('3', width - 15, height/2);
  text('3', width/2 - 15, 10);
  text('-3', width/2 - 15, height - 10);
  text('f(x)', width/2 + 5, 10);
  
  //text for sliders
  text('a', 15, 35);
  text('b', 15, 55);
}

function setup() {
  createCanvas(400, 400);
  background(255);
  stroke(0);
  translate(0,height/2);
  
  
  a_slider = createSlider(0, 1, 0.5, 0.1);
  b_slider = createSlider(0.1, 6, 0.1,0.01);
  a_slider.position(25, 20);
  b_slider.position(25, 40);
  
  checkbox = createCheckbox('animation', true);
  checkbox.changed(myCheckedEvent);
  checkbox.position(width - 100, 20);
  
}

function myCheckedEvent() {
  if (this.checked()) {
    flag_animation = true;
    b = 0.1;
  } else {
    flag_animation = false;
    b = 5;
  }
}

function draw() {
  background(255);
  
  if(flag_animation){
    if(frameCount % 2 == 0) {
      if(flagup){
        b += 0.01;
        if(b >= 5){
          flagup = false;
          flagdown = true;
        }
      }else{
        b -= 0.01;
        if(b<=0.1){
          flagup = true;
          flagdown = false;
        }
      }
    }//framecount
  }//flag animation
  else{
    a = a_slider.value();
    b = b_slider.value();
  }
  drawAxis();
  stroke(color(255,0,100));
  for(let i=0; i<width; i++){
    let fx=0;
    let x=map(i, 0, width, -3, 3);
    for(let n=0; n<50; n++){
      fx += ( Math.pow(a,n) * cos(Math.pow(b, n) * PI * x) );
    }
    let j = map(fx, 3, -3, 0, height);
    //print("x: " + x, "fx: "+ fx);
    
    ni = i;
    line(ni,nj, i, j);  
    nj = j;
    
  }
}
