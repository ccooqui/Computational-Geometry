//Erica Romero 2018

class Point {
  
   PVector p;

   Point( float x, float y ){
     p = new PVector(x,y);
   }
   
   void draw(){
      display();
   }
   
   void display(){
     fill(50);
     ellipse(p.x, p.y, 10, 10);
   }
  
}
