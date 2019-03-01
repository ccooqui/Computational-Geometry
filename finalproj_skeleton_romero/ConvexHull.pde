//Erica Romero 
//UID 7115-2531

ArrayList ConvexHullGiftWrapped( ArrayList<Point> points ){
  ArrayList<Point> cHull = new ArrayList();
  //check if there enough points to make a polygon
  if (points.size() >= 3) {
    //create a copy of the array to manipulate 
    ArrayList<Point> pointsCopy = new ArrayList<Point>();
    for (Point p : points){
      pointsCopy.add(p);
    }
    
    Point currentPoint = points.get(0);
    //find lowest point in points set 
    for (Point point : points ){
        if (currentPoint.getY() > point.getY()){
            currentPoint = point;
        }
    }
    
    //add lowest point to hull
    cHull.add(currentPoint);
    //pointsCopy.remove(currentPoint);
    PVector base = new PVector(1, 0);
    Boolean flag = true;
    
    //while the current point is not the first point in the polygon
    while (flag){
      Point minPoint = null;
      float minAngle = 2*(PI);
      
      //for all points find the point with the smallest angle
      for (Point nextPoint : pointsCopy) { //<>//
            if (nextPoint != currentPoint) {
              PVector nextV = new PVector(nextPoint.getX() - currentPoint.getX(), nextPoint.getY() - currentPoint.getY());
              if (PVector.angleBetween(nextV, base) < minAngle) {
                  minPoint = nextPoint;
                  minAngle = PVector.angleBetween(base, nextV);
              }
            }
        } 
        //if the minPoint is the first in the convex hull break
        if (minPoint == cHull.get(0)) {
          flag = false;
        }
        else{
          cHull.add(minPoint);
          base = new PVector(minPoint.getX() - currentPoint.getX(), minPoint.getY() - currentPoint.getY());
          pointsCopy.remove(minPoint);
          currentPoint = minPoint;
        }
   }
   
 }
  return cHull;
}
