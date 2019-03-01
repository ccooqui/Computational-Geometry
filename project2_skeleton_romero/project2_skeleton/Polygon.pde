//Erica Romero
//U71152531

class Polygon {
  
   ArrayList<Point> p     = new ArrayList<Point>();
   ArrayList<Edge>  bdry = new ArrayList<Edge>();
     
   Polygon( ){  }
   
   
   boolean isClosed(){ return p.size()>=3; }
   
   
   boolean isSimple(){
     // TODO: Check the boundary to see if it is simple or not.
     ArrayList<Edge> bdry = getBoundary();
     int intCount = 0;
     //using bdry check each edge against each other and check if they interesect
     for (int i = 0; i < bdry.size(); i++) {
         Edge tempEdge1 = bdry.get(i);
         for (int j = i+1; j < bdry.size(); j++){
           Edge tempEdge2 = bdry.get(j);
           if (tempEdge1.intersectionTest(tempEdge2)) {
             intCount++;
           }
         }
     }
     if (isClosed() && (intCount%bdry.size() == 0)) {
       return true;
     }
     else {
       return false;
     }
   }
   
   
   boolean pointInPolygon( Point p ){
     // TODO: Check if the point p is inside of the 
     ArrayList<Edge> bdry = getBoundary();
     Point newPointX = new Point(p.getX(), 0.0);
     Point newPointY = new Point(0.0, p.getY());
     //rays to check in horizontal and vertical orientation
     Edge newEdgeX = new Edge(p, newPointX);
     Edge newEdgeY = new Edge(p, newPointY);
     int intCountX = 0;
     int intCountY = 0;
     for (int i = 0; i < bdry.size(); i++){
       if (newEdgeX.intersectionTest(bdry.get(i))){
         intCountX++;
       }
       if (newEdgeY.intersectionTest(bdry.get(i))) {
         intCountY++;
       }
     }
     //if the count for intersection for either is even then the point is not in the polygon
     if (intCountX%2 == 0 || intCountY%2 == 0){
       return false;
     }
     else return true;
   }
   
   
   ArrayList<Edge> getDiagonals(){
     // TODO: Determine which of the potential diagonals are actually diagonals
     ArrayList<Edge> bdry = getBoundary();
     ArrayList<Edge> diag = getPotentialDiagonals();
     ArrayList<Edge> ret  = new ArrayList<Edge>();
     //check for all potential diagonals if the midpoint is in polygon
      for (Edge diagE : diag) {
        Point diagMid = diagE.midpoint();
        if (pointInPolygon(diagMid)) { 
          //if diagonal midpoint is in polygon check to see if it also intersects with the boundary
          boolean intFlag = false;
          for (Edge bdryE : bdry) {
            if (!(diagE.p0 == bdryE.p0 || diagE.p0 == bdryE.p1 || diagE.p1 == bdryE.p0 || diagE.p1 == bdryE.p1)) {
              if (diagE.intersectionTest(bdryE)) {
                intFlag = true;
              }
            }
          }
          if (!intFlag) {
            ret.add(diagE);
          }
        }
      }
     return ret;
     
   }
   
   boolean ccw(){
     // TODO: Determine if the polygon is oriented in a counterclockwise fashion
     if( !isClosed() ) return false;
     if( !isSimple() ) return false;
      
      int sum = 0;
      //for each set of edges in polygon take the sum of the points and if > 0 it is ccw
      for (int i = 0; i < p.size(); i++) {
        Point p1 = p.get(i);
        Point p2 = p.get((i+1)%p.size());
        sum += ((p1.getX() - p2.getX())*(p1.getY()+p2.getY()));
      }
      if (sum > 0) {
        return true;
      }
      else return false;
   }
   
   
   boolean cw(){
     // TODO: Determine if the polygon is oriented in a clockwise fashion
     if( !isClosed() ) return false;
     if( !isSimple() ) return false;
     int sum = 0;
     //for each set of edges in polygon take the sum of the points and if < 0 it is ccw
     for (int i = 0; i < p.size(); i++) {
        Point p1 = p.get(i);
        Point p2 = p.get((i+1)%p.size());
        sum += ((p1.getX() - p2.getX())*(p1.getY()+p2.getY()));
      }
      if (sum < 0) {
        return true;
      }
      else return false;
   }
      
   
   
   
   ArrayList<Edge> getBoundary(){
     return bdry;
   }


   ArrayList<Edge> getPotentialDiagonals(){
     ArrayList<Edge> ret = new ArrayList<Edge>();
     int N = p.size();
     for(int i = 0; i < N; i++ ){
       int M = (i==0)?(N-1):(N);
       for(int j = i+2; j < M; j++ ){
         ret.add( new Edge( p.get(i), p.get(j) ) );
       }
     }
     return ret;
   }
   

   void draw(){
     println( bdry.size() );
     for( Edge e : bdry ){
       e.draw();
     }
   }
   
   
   void addPoint( Point _p ){ 
     p.add( _p );
     if( p.size() == 2 ){
       bdry.add( new Edge( p.get(0), p.get(1) ) );
       bdry.add( new Edge( p.get(1), p.get(0) ) );
     }
     if( p.size() > 2 ){
       bdry.set( bdry.size()-1, new Edge( p.get(p.size()-2), p.get(p.size()-1) ) );
       bdry.add( new Edge( p.get(p.size()-1), p.get(0) ) );
     }
   }

}
