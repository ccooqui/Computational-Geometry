class Polygon {
  
   ArrayList<Point> p = new ArrayList<Point>();
   ArrayList<Edge>  bdry = new ArrayList<Edge>();
   ArrayList<Point> innerPoints = new ArrayList<Point>();
   ArrayList<Point> outerPoints = new ArrayList<Point>();
   ArrayList<Point> intersectionPoints = new ArrayList<Point>();
   
   int numOfPoints = 20;
     
   Polygon( ){ 
     generateRandomPoints();
     createEdges(p);
   }
   
   void draw() {
     strokeWeight(3);
     noFill();
     stroke(100);
     for( Edge e : bdry ){
       e.draw();
     }
     
     fill(0);
     noStroke();
     for( Point points : p ){
       points.draw();
     }
   
   }
   
   void createEdges(ArrayList<Point> p){
     int N = p.size();

     for(int i = 0; i < N; i++ ){
       Point p0 = p.get(i);
       Point p1 = p.get((i+1)%N);
       
       Edge e = new Edge(p0, p1);
       bdry.add(e);
     }
   }
   
   void addPoint( Point _p ){ p.add( _p ); }
   
   void generateRandomPoints(){
     for( int i = 0; i < numOfPoints; i++){
        p.add( new Point( random(100,width-100), random(100,height-100) ) );
     }
     p = ConvexHullGiftWrapped(p);
   }
   
   /*void updatePoint () {
     p = ConvexHullGiftWrapped(p);
   }*/
      
   ArrayList<Edge> getBoundary(){
     return bdry;
   }
   
   ArrayList<Point> getPoints(){
     return p;
   }
   
   ArrayList<Point> getInnerPoints(){
     return innerPoints;
   }
   
   ArrayList<Point> getOuterPoints(){
     return outerPoints;
   }
   ArrayList<Point> getInterPoints(){
     return intersectionPoints;
   }
   
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
   
}
