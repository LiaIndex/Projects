float aumento=0.0;
 /* int ancho=2000;
    int alto=2000;*/
    int iteraciones=1500;
   
    int brigh;
    float a; 
    float b; 
    float ca;
    float cb;
    int n;
    float aa;
    float bb;
    
    
void setup(){
   size(1000,1000);
   for(int x = 0; x  < width; x++){
        for(int y=0; y <= height/2; y++){

                 a = map(x, 0, width, -2, 2);
                 b = map(y, 0, height, -2, 2);

                 ca = a;
                 cb=b;

                 n=0;
            

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

            brigh =color(map(n, 0, iteraciones, 0, 255),0,map(n, 0, iteraciones, 0, 158));
            if(n==iteraciones) brigh=0;


            
            set(x,y,color(brigh));
            set(x,height-y,color(brigh));

        }
    }
    updatePixels();
}
void draw(){
  //translate(0,500);
  
  
}
