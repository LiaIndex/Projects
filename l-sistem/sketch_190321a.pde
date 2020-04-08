/*
serpiensky
  a_1 r_1 angle 2*PI/3 F-G-G

arbolito 1
  a2 r2 angle 25*PI/180; X 

arbolito 2  
  a2 r3 angle PI/20; X
  
arbolito 3
  a2 r3_ angle 27.5*PI/180 X
  
dragon kurve
  a4 r4 angle PI/2 X

*/
boolean debug = true;
/**
* all the alphabets are called variablesi
* they will be stored in the matrix "variables"
*/
char[] variables_1 = {'F','G','+','-'};
char[] variables2 = {'X','F','+','-','[',']'};
char[] variables3 = {'X','F','+','-','[',']'};
char[] variables3_ = {'X','F','+','-','[',']'};
char[] variables4 = {'X','Y','F','+','-'};

/**
* Each character of the alphabet has an associated rule
* when the function "itera" find a specific character it will be 
* replaced with the corresponding rule
* the rules are called rulesi and are stored in the matrix "rules_"
*/
String[] rules_1 = {"F-G+F+G-F","GG","+","-"};
String[] rules2 = {"F+[[X]-X]-F[-FX]+X","FF","+","-","[","]"};
String[] rules3 = {"+F-F-[-F-F-[-X+X[F]]]+X+[XF]","FF","+","-","[","]"};
String[] rules3_ ={"F[+X][-X]FX","FF","+","-","[","]"};
String[] rules4 = {"X+YF+","-FX-Y","F","+","-"};

//the most simple aprouch (kyss) is to make the length of the matrixes
//which contains the alphabets, the rules, the axioms (starting characters) and the angles
//all the same, and keep an index (index_variable_rules_angle) to know which combination
//of alphabet-axiom-angle-&-rules to have a consistence for the resulting l-system

char[][] variables = {variables_1, variables2, variables3, variables3_, variables4};
String[][] rules_ = {rules_1, rules2, rules3, rules3_, rules4};
String[] axiomas = {"F-G-G", "X", "X", "X", "X"};
float[] angles = {2*PI/3, 25 * PI/180, PI/20, 27.5 * PI/180, PI/2};


int index_variable_rules_angle = 1;

char[] choosen_variables= variables[index_variable_rules_angle];
String[] choosen_rules =rules_[index_variable_rules_angle];
float angle= angles[index_variable_rules_angle];
      //"F-G-G";
      //"X";
      //"FX";
      //"A";
String cadena = axiomas[index_variable_rules_angle];
              
int iteraciones =6;

//cont is a variable used to know if the program has to do more iterations
//expanding the chain and keep drawing (if cont<iteraciones then keep)
int cont=0;
int len=5;
//translate variables
float tw;
float th;

float factor=2.5;
String cadena2=cadena;


void setup(){
  size(1080,970);
  background(255);
  stroke(0);
  tw = width*0.5;
  th = height;
  //scale(0.5);
}

void mouseClicked(){
  th = height;
  tw = width*0.5;
  iteraciones = 6;
  
  index_variable_rules_angle++;
  if(index_variable_rules_angle == variables.length) 
      index_variable_rules_angle = 0;
  if(index_variable_rules_angle == 4){
    //dragon kurve
    th = height*0.5;
    iteraciones = 13;
  }else if(index_variable_rules_angle == 2){
    iteraciones =5;
  }
  else if(index_variable_rules_angle == 0){
    th = height*0.75;
    tw = width*0.6;
  }

  background(255);
  cadena = axiomas[index_variable_rules_angle];
  cadena2=cadena;
  angle= angles[index_variable_rules_angle];
  choosen_variables= variables[index_variable_rules_angle];
  choosen_rules =rules_[index_variable_rules_angle];
  cont = 0;
  
  if(debug){
    String chosenv ="";
    String chosenr ="";
    for(int i=0; i<choosen_variables.length; i++){
      chosenv += " "+choosen_variables[i]+", ";
      chosenr += " "+choosen_rules[i]+", ";
    }
    print(cadena +" | " + angle +" | " + chosenv +" | " +chosenr +"\n");
  }
}

void draw(){
    if(cont<iteraciones){
      background(255);
      cadena=itera(cadena2);
      cadena2=cadena;
      cont++;
      
      translate(tw,th);
      rotate(-PI);
      
      for(int i=0; i<cadena.length();i++){
      
        if(cadena.charAt(i)=='F' || 
           cadena.charAt(i)=='G' || 
           cadena.charAt(i)=='A' ||
           cadena.charAt(i)=='B' ){
          
          line(0,0,0,len);
          translate(0,len);
          
          
        }
        else if(cadena.charAt(i)=='+'){
          //print("rota+");
          
          rotate(angle);
          
        }
        else if(cadena.charAt(i)=='-'){
          //print("rota-");
          
          rotate(-angle);
          
        }
        else if(cadena.charAt(i)=='['){
          //print("rota-");
          push();
          
        }
        else if(cadena.charAt(i)==']'){
          //print("rota-");
          pop();
          
        }
      
    }
    delay(500);
  }else{
   // print(cadena2);
   // noLoop();
  }
}


String itera(String ax){
 String resultado="";

 for(int i=0; i<ax.length(); i++){
   for(int j=0; j<choosen_variables.length; j++){
     if(ax.charAt(i)==choosen_variables[j]) resultado+=choosen_rules[j];
     
   }
 }
 return resultado;
}
