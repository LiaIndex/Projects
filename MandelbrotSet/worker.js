
let iterac=5000;
let w=700;

let h=700;

let b;
let aa,bb;

let ca;
let cb;
let n
let x1=0,y1;

let fila=[];
let libre = true;

var mapMaxX2=2;
var mapMaxY2=2;
var mapMinX2=-2;
var mapMinY2=-2


let l= (mapMaxX2-mapMinX2)/w;

runing = function(){
    postMessage(libre);
}



onmessage = function(e) {
    
        if(Array.isArray(e.data)){
           // console.log(e.data);
           libre=false;
            mapMaxX2=e.data[0];
            mapMaxY2=e.data[1];
            mapMinX2=e.data[2];
            mapMinY2=e.data[3];
            //l= (mapMaxX2-mapMinX2)/w;
            libre=true;
            //postMessage(true);
        }
        else{
        let a=mapMinX2;
        //console.log(mapMaxX2,mapMaxY2,mapMinX2,mapMinY2);
        libre=false;
        let y1 = e.data;
        b=map1(y1,0,h,mapMinY2,mapMaxY2);
        while(x1<w){

        
            //console.log("lol");
            
            a=map1(x1,0,w,mapMinX2,mapMaxX2);
            
            n=itera(a,b);
           
            fila.push({
                x: x1,
                y: y1,
                it: n
            });

            x1++;
            if(a>=mapMaxX2)a=mapMinX2;
            /*fila4.push({
            y: y+3,
            MinX :mapMinX,
            MaxX :mapMaxX,
            MinY :mapMinY,
            MaxY :mapMaxY}
            );*/
        }
        //if(x1%100==0)console.log("pixeles worker " + fila.length);
        /*console.log("maxX: "+mapMaxX2 +"\n"+
        "maxY: "+mapMaxY2 +"\n"+
        "minX: "+mapMinX2 +"\n"+
        "minY: "+mapMinY2 +"\n"+
        fila.length
        );*/
        postMessage(fila);
        fila=[];
    
        x1=0;
        libre=true;
        /*
        for(let v=0; v<e.data.length; v++){
            
    //x,y,mapMinX,mapMaxX,mapMinY,mapMaxY]
            x1=e.data[v][0];
            xprueba  += l;

            
            y1=e.data[v][1];
            
            a=map1(x1,0,w,e.data[0][2],e.data[0][3]);
            b=map1(y1,0,w,e.data[0][4],e.data[0][5]);

            console.log("compara a: "+a+"  prueba: "+xprueba);
            n=itera(a,b);
            fila.push([xprueba,y1,n]);
            //console.log(x,y);
            //map(x, 0, width, mapMinX, mapMaxX),map(y+1, 0, height, mapMinY, mapMaxY)
        }*/
        
        }
}

function itera(a,b){
    ca = a;
    cb = b;
    let n1=0;
    while (n1<iterac){
            
        aa = a * a-b *b;
        bb = 2  * a * b;
    
         a= aa+ca;
         b= bb +cb;
    
         if(((a*a)+(b*b))>=4){
             break;
         }
    
         n1++;
    }
        
    return n1;
}

function map1 (value, istart, istop,  ostart, ostop) {
return ostart + (ostop - ostart) * ((value - istart) / (istop - istart));
}
