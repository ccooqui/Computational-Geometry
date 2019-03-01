//Erica Romero 2018

class Edge{
  
   Point p0,p1;
      
   Edge(Point _p0, Point _p1 ){
     p0 = _p0;
     p1 = _p1;
   }
   
   void draw(){
     display();
   }
   void display(){
     strokeWeight(2.5);
     stroke(58, 51, 50);   
     line(p0.p.x, p0.p.y, p1.p.x, p1.p.y);
   }
}
