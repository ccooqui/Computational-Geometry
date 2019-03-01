class Ray {
  PVector startPoint;
  
  
   PVector eVector(Edge e) {
     PVector v = new PVector(e.p1.getX() - e.p0.getX(), e.p1.getY() - e.p0.getY());
     return v;
   }
  

}
