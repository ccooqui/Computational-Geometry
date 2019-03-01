

class Triangle {
  
   Point p0,p1,p2;
//Erica Romero 2018     
     
   Triangle(Point _p0, Point _p1, Point _p2 ){
     p0 = _p0;
     p1 = _p1;
     p2 = _p2;
   }
   
   void draw(){
    display();
   }
   
   void display(){
     noStroke();
     if (ccw()){
       fill(185, 224, 69, 75);
     }
     else if (cw()){
       fill(255, 110, 94, 75);
     }
     else {
       noFill();
     }
     triangle(p0.p.x, p0.p.y, p1.p.x, p1.p.y, p2.p.x, p2.p.y);
     
   }
   // check if a triangle is oriented counterclockwise
   boolean ccw(){
     PVector v1 = new PVector();
     PVector v2 = new PVector();
     PVector v3 = new PVector();
     PVector.sub(p1.p, p0.p, v1);
     PVector.sub(p2.p, p1.p, v2);
     PVector.cross(v1, v2, v3);
     if (v3.z >  0) {
       return true;
     }
     else {
       return false;
     }
   }
   
   // check if a triangle is oriented clockwise
   boolean cw(){
     PVector v1 = new PVector();
     PVector v2 = new PVector();
     PVector v3 = new PVector();
     PVector.sub(p1.p, p0.p, v1);
     PVector.sub(p2.p, p1.p, v2);
     PVector.cross(v1, v2, v3);
     if (v3.z <  0) {
       return true;
     }
     else {
       return false;
     }
   }
   
   
}
