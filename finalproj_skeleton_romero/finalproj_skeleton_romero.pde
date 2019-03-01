import java.util.*;
// Please forgive the mess :")

ArrayList<Point>    points   = new ArrayList<Point>();
ArrayList<Edge>     edges      = new ArrayList<Edge>();
ArrayList<Edge>     iedges     = new ArrayList<Edge>();
ArrayList<Point>    ipoints   = new ArrayList<Point>();
ArrayList<Polygon>  polygons = new ArrayList<Polygon>();
ArrayList<Event>    events = new ArrayList<Event>();


int numOfPoly = 2;
void generatePolygons() {
  for (int i = 0; i < numOfPoly; i++) {
    Polygon poly = new Polygon();
    polygons.add(poly);
  }
}


void setup() {
  size(800, 800, P3D);
  frameRate(30);
  noLoop();
}


void draw() {
  background(255);

  translate( 0, height, 0);
  scale( 1, -1, 1 );

  strokeWeight(3);

  for ( Polygon p : polygons) {
    p.draw();
  }
  stroke(60, 0, 200);
  for (Edge e : iedges) {
    int i = 100;
    int j = 200;
    int k = 100;
    e.draw();
    stroke(i, j, k);
    i += 100;
    k -= 100;
  }
  fill(0);
  stroke(230, 0, 100);
  for ( Point ip : ipoints) {
    ip.draw();
  }

  fill(0);
  stroke(0);
  textSize(18);

  textRHC( "Controls", 10, height-20 );
  textRHC( "g: Generate Polygons", 10, height-40 );
  textRHC( "c: clear polygons", 10, height-60 );
}


void keyPressed() {
  if ( key == 'g' ) { 
    generatePolygons(); 
    advanceRules(polygons.get(0), polygons.get(1)); 
    redraw();
  }
  if ( key == 'c' ) { 
    polygons.clear(); 
    iedges.clear(); 
    ipoints.clear(); 
    redraw();
  }
  if ( key == 'n' ) { 
    redraw();
  }
}

void textRHC( int s, float x, float y ) {
  textRHC( Integer.toString(s), x, y );
}


void textRHC( String s, float x, float y ) {
  pushMatrix();
  translate(x, y);
  scale(1, -1, 1);
  text( s, 0, 0 );
  popMatrix();
}

Polygon advanceRules(Polygon p, Polygon q) {
  //polygon object that will hold the intersection polygon
  Polygon intersectionPoly = new Polygon();
  
  // First point check to see if a intersection point has been found //
  Boolean firstPoint = true;
  
  // Max advances for each polygon //
  int qSize = q.bdry.size();
  int maxQ = 2*q.bdry.size();
  
  int pSize = p.bdry.size();
  int maxP = 2*p.bdry.size();
  
  //trackers for current edge
  int pEdgeTracker = 0;
  int qEdgeTracker = 0;
  
  Edge pEdge = p.bdry.get(pEdgeTracker);
  Edge qEdge = q.bdry.get(qEdgeTracker); 
  iedges.add(pEdge);
  iedges.add(qEdge);

  int loopCount = 0;

  while (((pEdgeTracker < pSize) || (qEdgeTracker < qSize) && pEdgeTracker < maxP && qEdgeTracker < maxQ)) {
     //-------------------------------------------
     //Check if lines intersect
     //-------------------------------------------
     Event newEvent = new Event();
     newEvent.currentEdges.add(pEdge);
     newEvent.currentEdges.add(pEdge);
     if (onHalfPlane(pEdge, qEdge) == true) {
         print("q is to the left\n");
     }
     else {
       print("p is to the left\n");
     }
     if (pEdge.intersectionTest(qEdge)) {
        // Find intersection point //
        Point inPoint = pEdge.intersectionPoint(qEdge);
        
        // Check if intersection point list is empty //
        if (firstPoint){
          firstPoint = false;
          ipoints.add(inPoint);
          
          // Check which point is outside and which point is inside //
          if (p.pointInPolygon(qEdge.p1) && !q.pointInPolygon(pEdge.p1)){
            p.outerPoints.add(pEdge.p1);
            q.innerPoints.add(qEdge.p1);
          }
          else {
            q.outerPoints.add(qEdge.p1);
            p.innerPoints.add(pEdge.p1);
          }
          //advance p
          pEdgeTracker++;
          pEdge = p.bdry.get((pEdgeTracker)%p.bdry.size());
        }
        else {
            if (inPoint == ipoints.get(0)) {
              print("point is equal to starting point");
              break;
            } 
            else {
               ipoints.add(inPoint);
               // Check if which point is outside and which point is inside //
               if (p.pointInPolygon(qEdge.p1) && !q.pointInPolygon(pEdge.p1)){
                  p.outerPoints.add(pEdge.p1);
                  q.innerPoints.add(qEdge.p1);
                }
                else {
                  q.outerPoints.add(qEdge.p1);
                  p.innerPoints.add(pEdge.p1);
                }
                //advance p
                pEdgeTracker++;
                pEdge = p.bdry.get((pEdgeTracker)%p.bdry.size());
           }
        }
     }
     else{
       //-------------------------------------------
       //If p and q aim at each other
       //-------------------------------------------
       if (aim(pEdge,qEdge) && aim(qEdge,pEdge)){
          print("They point at each other.\n");
          if (onHalfPlane(pEdge,qEdge)){
            print("advance p\n");
            if (q.pointInPolygon(pEdge.p1)){
              p.innerPoints.add(pEdge.p1);
              ipoints.add(pEdge.p1);
            }
            else {
              p.outerPoints.add(pEdge.p1);
            }
            pEdgeTracker++;
            pEdge = p.bdry.get((pEdgeTracker)%p.bdry.size());
          }
          else{
            print("advance q\n");
            if (p.pointInPolygon(qEdge.p1)){
              q.innerPoints.add(qEdge.p1);
              ipoints.add(qEdge.p1);
            }
            else {
              q.outerPoints.add(qEdge.p1);
            }
            qEdgeTracker++;
            qEdge = q.bdry.get((qEdgeTracker)%q.bdry.size());
          }
       }
       //-------------------------------------------
       //If q points at p but p does not point at q
       //-------------------------------------------
       else if(!aim(pEdge,qEdge) && aim(qEdge,pEdge)) {   
          print("q points at p\n advance q\n");
          if (p.pointInPolygon(qEdge.p1)){
            q.innerPoints.add(qEdge.p1);
            ipoints.add(qEdge.p1);
          }
          else {
            q.outerPoints.add(qEdge.p1);
          }
          qEdgeTracker++;
          qEdge = q.bdry.get((qEdgeTracker)%q.bdry.size());
       }
       //-------------------------------------------
       //If p points at q but q does not point at p
       //-------------------------------------------
       else if (aim(pEdge,qEdge) && !aim(qEdge,pEdge)){
          print("p points at q\n advance p\n");
          if (q.pointInPolygon(pEdge.p1)){
            p.innerPoints.add(pEdge.p1);
            ipoints.add(pEdge.p1);
          }
          else {
            p.outerPoints.add(pEdge.p1);
          }
          pEdgeTracker++;
          pEdge = p.bdry.get((pEdgeTracker)%p.bdry.size());
       }
       //-------------------------------------------
       //If they do not point at each other
       //-------------------------------------------
       else if (!aim(pEdge,qEdge) && !aim(qEdge,pEdge)){
          if (onHalfPlane(pEdge,qEdge)){
            print("advance p\n");
            if (q.pointInPolygon(pEdge.p1)){
              p.innerPoints.add(pEdge.p1);
            }
            else {
              p.outerPoints.add(pEdge.p1);
            }
            pEdgeTracker++;
            pEdge = p.bdry.get((pEdgeTracker)%p.bdry.size());
          }
          else{
            print("advance q\n");
            if (p.pointInPolygon(qEdge.p1)){
              q.innerPoints.add(qEdge.p1);
            }
            else {
              q.outerPoints.add(qEdge.p1);
            }
            qEdgeTracker++;
            qEdge = q.bdry.get((qEdgeTracker)%q.bdry.size());
          }
       }
     }
  }
  return intersectionPoly;
}

Boolean onHalfPlane(Edge pEdge, Edge qEdge) {
  PVector vect1 = pEdge.eVector();
  
  PVector x2 = new PVector(qEdge.p1.getX() - pEdge.p0.getX(), qEdge.p1.getY() - pEdge.p0.getY());
  float cross2 = x2.cross(vect1).z;
  if (cross2 >= 0){
    return true;
  }
  else {
    return false;
  }
  
}

Boolean aim(Edge edge1, Edge edge2) {
  //checks if edge1 points at edge2
  PVector vect1 = edge1.eVector();
  PVector vect2 = edge2.eVector();
  
  if ((vect1.cross(vect2).z > 0 && onHalfPlane(edge2,edge1)) || (vect1.cross(vect2).z < 0 && !onHalfPlane(edge2,edge1))) {
    return true;
  }
  else {
    return false;
  }
}
