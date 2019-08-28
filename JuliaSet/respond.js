/* File: respond.js */
let iteraciones=100;
let width=600;
let height=300;
// Setup an event listener that will handle messages sent to the worker.
self.addEventListener('message', function(e) {
    // Send the message back.
    //console.log("desde el worker");
    let x=e.data[0];
    let y=e.data[1];
    //console.log("x = "+x+" y= "+y);

    let a =mapito(x, 0, width, -2, 2);
    let b = mapito(y, 0, height, -2, 2);

    let ca = a;
    let cb=b;

    let n=0;

    let aa,bb;
    while (n<iteraciones){
                
        aa =  a *a-b *b;
        bb = 2  * a * b;

        a= aa +ca;
        b= bb +cb;

        if(((a*a)+(b*b))>=4){
            break;
        }

        n++;
    }
    //print("iteraciones  ---> "+n);
    self.postMessage([n,x,y]);
  }, false);
  function mapito(n,start1, stop1, start2, stop2){
    return ((n-start1)/(stop1-start1))*(stop2-start2)+start2;
};