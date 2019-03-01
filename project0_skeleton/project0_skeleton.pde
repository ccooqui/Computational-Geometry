//Erica Romero 2018

ArrayList<Point>    points    = new ArrayList<Point>();
ArrayList<Edge>     edges     = new ArrayList<Edge>();
ArrayList<Triangle> triangles = new ArrayList<Triangle>();
Point point1, point2, point3;
Edge edge;
Triangle triangle;
int pointCount = 0;

void setup(){
  size(800,800,P3D);
  frameRate(30);
}


void draw(){
  //clear the display
  pointCount = 0;
  background(255);  
  // code to convert the display into a RIGHT HAND coordinate system
  // remove if you're ok using a left hand coordinate system
  translate( 0, height, 0);
  scale( 1, -1, 1 );
  
    for(Point p : points){
      pointCount++;
      point1 = p;
      point1.draw();
      textRHC(pointCount, point1.p.x, point1.p.y);
    }
    for(Edge e : edges){
      edge = e;
      edge.draw();
    }

    for (Triangle t : triangles){
      triangle = t;
      triangle.draw();
    }
}


void mousePressed(){
  
  // calculate the mouse poisition in a RIGHT HAND coordinate system
  int mouseXRHC = mouseX;
  int mouseYRHC = height-mouseY;
  
  // Add the click to the point list, considering a RIGHT HAND coordinate system
  points.add(new Point(mouseXRHC,mouseYRHC));
  pointCount++;
  //// Use the following line instead, if using a left hand coordinate system
  //points.add( new Point(mouseX,mouseY) );
  
  if (pointCount >= 2){
    point1 = points.get(pointCount-1);
    point2 = points.get(pointCount-2);
    edges.add(new Edge(point1, point2));
    
    if ((pointCount % 3) == 0){
      point3 = points.get(pointCount-3);
        triangles.add(new Triangle(point1, point2, point3));
    }
  }

  // TODO: Further fill in this function
}

// Special functions to draw text in a RIGHT HAND coordinate system
void textRHC( int s, float x, float y ){
  textRHC( Integer.toString(s), x+5, y+5);
}

void textRHC( String s, float x, float y ){
  pushMatrix();
  translate(x,y);
  scale(1,-1,1);
  text( s, 0, 0 );
  popMatrix();
}

  
