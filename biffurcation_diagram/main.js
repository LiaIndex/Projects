/*
Example of Bifurcation diagram animation using P5 for JS
Author: Lia Belda
see also: https://www.vanderbilt.edu/AnS/psychology/cogsci/chaos/workshop/BD.html
*/

let x = 0.1;
let offset_ejes = 40;
let i = offset_ejes;
let offset = 300;
let r=0;
let minx = 1;
let maxx = 4;
let check = false;


function setup() {
  createCanvas(600, 400);
  background(0);
  textAlign(CENTER);
  
  draw_graph(minx, maxx);
}

function draw_graph(minx, maxx){
  stroke(255);
  fill(255);
  //eje y //bua loca
  push();
    line(offset_ejes, height - offset_ejes, offset_ejes+1, offset_ejes);
    translate(offset_ejes, height/2);
    text('1', -offset_ejes/4, -height/2 +offset_ejes);
    rotate(-PI/2);
    text('poblation (x) ', 0, -offset_ejes/2); 
    rotate(PI/2);
    text('0.1', -offset_ejes/4, height/2 -offset_ejes);
  pop();
  //eje x
  line(offset_ejes, height - offset_ejes, width -  offset_ejes, height - offset_ejes);
  text('feed rate (r) ', width/2,  height - offset_ejes/4);

  //lineas
  
  for(let j=offset_ejes; j<height - offset_ejes; j+=(height - 2*offset_ejes)/10){
      line(offset_ejes, j, width -  offset_ejes, j);

  }
  for(let j=offset_ejes; j<=width - offset_ejes; j+=(width - 2*offset_ejes)/10){
      line(j,offset_ejes,j,height - offset_ejes);
      text(map(j,offset_ejes,width - offset_ejes,minx,maxx).toFixed(2),
           j, height - offset_ejes/1.5); 
  }
}

function mouseClicked() {
  if(check){
  background(0);
    if(minx == 1){
      minx = 3.5;
    }else{
      minx = 1;
    }
    draw_graph(minx,maxx)
    check = false;
    loop();
  }
}

function draw() {
  
  
  
  stroke(color(240,0,240,20));
  
  if((r > 3.45 && r < 3.6 ) || (r > 3 && r < 3.05 ) ){
    stroke(color(0,250,0,50));
    line(i, offset_ejes, i, height - offset_ejes);
    stroke(color(240,0,240,20));
  }
  for(let j=0; j<1000; j++){
    
    r = map(i, offset_ejes, width-offset_ejes, minx, maxx);
    let nx =r*x*(1-x);
    let mnx = map(nx, 0, 1, height - offset_ejes, offset_ejes);
  
  
    point(i, mnx);
    i+=0.001;
    x = nx;
    
    if(r>=4){
      print(i);
      i=offset_ejes; 
      check = true; 
      noLoop();
    }
  }
  
}