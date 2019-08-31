int rows=250;
int columns = 250;

int[][] matriz = new int[rows][columns];
int[][] nextMatriz = matriz;

float ladoCelda = 2;

void setup(){
  size(500,500);
  for(int i=1; i<matriz.length; i++){
    for(int j=1; j<matriz[i].length; j++){
      //matriz[i][j]=(int)random(0,9)%2;
     // print(matriz[i][j]);
    }
  }
 for(int i=40; i<210; i++){
   
   matriz[i][125]=1;
   matriz[i][50]=1;
   matriz[i][200]=1;
   matriz[i][i]=1;
   matriz[125][i]=1;
   matriz[50][i]=1;
   matriz[200][i]=1;
 }
 

 
}
void draw(){
  
  for(int i=1; i<rows-1; i++){
    for(int j=1; j<columns-1; j++){
      if(matriz[i][j]==1){
        fill(0);
        if(neightbours(i,j)==2 || neightbours(i,j)==3){nextMatriz[i][j]=1;}
        else{nextMatriz[i][j]=0;}
      }
      else{
        fill(255);
        if(neightbours(i,j)==3){nextMatriz[i][j]=1;}/*(neightbours(i,j)==3 || neightbours(i,j)==2){nextMatriz[i][j]=1;}*/
      }
      square(ladoCelda*i,ladoCelda*j,ladoCelda);
      
    }
  }
  int[][] temp  = new int[rows][columns];
  matriz=nextMatriz;
  nextMatriz=temp;
  
  //delay(5);


}
/*Una célula muerta con exactamente 3 células vecinas vivas "nace" (es decir, al turno siguiente estará viva).
Una célula viva con 2 o 3 células vecinas vivas sigue viva, en otro caso muere (por "soledad" o "superpoblación").*/
int neightbours(int i, int j){
  int cont=0;
  
if(matriz[i-1][j]==1){cont++;}
  if(matriz[i+1][j]==1){cont++;}
  if(matriz[i][j-1]==1){cont++;}
  if(matriz[i][j+1]==1){cont++;}
  if(matriz[i+1][j+1]==1){cont++;}
  if(matriz[i+1][j-1]==1){cont++;}
  if(matriz[i-1][j+1]==1){cont++;}
  if(matriz[i-1][j-1]==1){cont++;}


  return cont;
}
