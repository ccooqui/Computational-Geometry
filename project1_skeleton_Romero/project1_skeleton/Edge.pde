

class Edge{
  
   Point p0,p1;
      
   Edge(Point _p0, Point _p1 ){
     p0 = _p0; p1 = _p1;
   }
   
   void draw(){
     line( p0.p.x, p0.p.y, 
           p1.p.x, p1.p.y );
   }
   
   boolean intersectionTest( Edge other ){
     // TODO: Implement The Cross Product Based Test To Determine If 2 Edges Intersect 
     if ((p0.p.x == other.p0.p.x) || (p1.p.x == other.p1.p.x)){
       return false;
     }
     else {
       float w,x,y,z;
       PVector v0, v1, v2, v3, v4, v5, v6, v7;
       
       v0 = PVector.sub(other.p0.p, p0.p);
       v1 = PVector.sub(other.p1.p, p0.p);
       v2 = PVector.sub(other.p0.p, p1.p);
       v3 = PVector.sub(other.p1.p, p1.p);
       v4 = PVector.sub(p0.p, other.p0.p);
       v5 = PVector.sub(p1.p, other.p0.p);
       v6 = PVector.sub(p0.p, other.p1.p);
       v7 = PVector.sub(p1.p, other.p1.p);
  
       w = v0.cross(v1).z;
       x = v2.cross(v3).z;
       y = v4.cross(v5).z;
       z = v6.cross(v7).z;
  
      if ( ((w > 0 && x < 0) || (w < 0 && x > 0)) && ((y > 0 && z < 0) || (y < 0 && z > 0)) )
      {
         return true;
      }
      else {
         return false;
      }
     }
   }
   
   
 Point intersectionPoint( Edge other ){
     if (intersectionTest(other) == true){
        float u; 
        PVector r = PVector.sub(other.p0.p, p0.p);
        PVector d = PVector.sub(p1.p, p0.p);
        PVector q = PVector.sub(other.p1.p, other.p0.p);
        
        u = (r.cross(d).z) / (d.cross(q).z);
        
        float t;
        
        if (d.x != 0) {
          t = ((r.x + (q.x*u)) / d.x);
        }
        else if (d.y != 0){
          t = (r.y + (q.y*u) / d.y);
        }
        else {
          return null;
        }
        
        PVector p = PVector.add(p0.p, d.mult(t) );
        
        Point intPoint = new Point(p.x, p.y);
        return intPoint;
     }
     else {
       return null;
     }
   }
   
   Point optimizedIntersectionPoint( Edge other ){
     // TODO: Implement A Faster Method To Find The Edge Intersection Point
     // The result should be correct, but SPEED MATTERS.
    Point intPoint;
     
    float u, rx, ry, dx, dy, qx, qy, t; 
    rx = (other.p0.p.x - this.p0.p.x);
    ry = (other.p0.p.y - this.p0.p.y);
    dx = (this.p1.p.x - this.p0.p.x);
    dy = (this.p1.p.y - this.p0.p.y);
    qx = (other.p1.p.x - other.p0.p.x);
    qy = (other.p1.p.y - other.p0.p.y);    
    
    float cross1 = ((rx*dy) - (ry*dx));
    float cross2 = ((dx*qy) - (dy*qx));
    u = (cross1) / (cross2);
    
    if (u < 0 || u > 1)
    {
    return null;
    } 
    if (dx != 0) {
    t = ((rx + (qx*u)) / dx);
    }
    else if (dy != 0){
    t = (ry + (qy*u) / dy);
    }
    else {
    return null;
    }
    
    if (t < 0 || t > 1)
    {
      return null;
    } 
    float pTempx = p0.p.x + (dx*t);
    float pTempy = p0.p.y + (dy*t);
    
    intPoint = new Point(pTempx, pTempy);
    return intPoint;
  }
}
