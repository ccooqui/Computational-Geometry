/*Polygon advanceRules(Polygon p, Polygon q) {
  //polygon object that will hold the intersection polygon
  Polygon intersectionPoly = new Polygon();
  
  int maxRun = 2*(p.bdry.size() + q.bdry.size());
  //trackers for current edge
  int pEdgeTracker = 0;
  int qEdgeTracker = 0;
  
  Edge pEdge = p.bdry.get(pEdgeTracker);
  Edge qEdge = q.bdry.get(qEdgeTracker); 
  iedges.add(pEdge);
  iedges.add(qEdge);

  Boolean flag = true;
  int loopCount = 0;

while (flag == true && loopCount <= maxRun) {
  print("start of loop\n");
 if (pEdge.intersectionTest(qEdge) || qEdge.intersectionTest(pEdge)) {
    print("intersect\n");
    Point inPoint = pEdge.intersectionPoint(qEdge);
    
    //POINT ARRAY SIZE CHECK DONE
    if (ipoints.size() < 1){
      ipoints.add(inPoint);
      //advance p
      pEdgeTracker++;
      pEdge = p.bdry.get((pEdgeTracker)%p.bdry.size());
    }
    else {
      if (inPoint == ipoints.get(0)) {
        print("point is equal to starting point");
        flag = false;
      } 
      else {
        //check if inside p or q?
        if (q.pointInPolygon(pEdge.p1)){
          ipoints.add(pEdge.p1);
        }
        if (p.pointInPolygon(qEdge.p1)) {
          ipoints.add(qEdge.p1);
        }
        ipoints.add(inPoint);

        if (onHalfPlane(pEdge,qEdge)){
          print("advance p\n");
          pEdgeTracker++;
          pEdge = p.bdry.get((pEdgeTracker)%p.bdry.size());
        }
        else{
          print("advance q\n");
          qEdgeTracker++;
          qEdge = q.bdry.get((qEdgeTracker)%q.bdry.size());
        }
      }
    }
    //DONE
  }
  else {   
    if (aim(pEdge,qEdge) && aim(qEdge,pEdge)){
      print("They point at each other.\n");
      if (onHalfPlane(pEdge,qEdge)){
        print("advance p\n");
        pEdgeTracker++;
        pEdge = p.bdry.get((pEdgeTracker)%p.bdry.size());
      }
      else{
        print("advance q\n");
        qEdgeTracker++;
        qEdge = q.bdry.get((qEdgeTracker)%q.bdry.size());
      }
    }
    
    if(!aim(pEdge,qEdge) && aim(qEdge,pEdge)) {
      print("q points at p\n advance q\n");
      if (p.pointInPolygon(qEdge.p1)){
        print("add q to intersection");
        //ARRAY POINT SIZE CHECK DONE
        if (ipoints.size() < 1){
          ipoints.add(qEdge.p1);
          qEdgeTracker++;
          qEdge = q.bdry.get((qEdgeTracker)%q.bdry.size());
        
        }
        else{
          if (qEdge.p1 == ipoints.get(0)) {
            print("point is equal to starting point");
            flag = false;
          } 
          else {
            ipoints.add(qEdge.p1);
            qEdgeTracker++;
            qEdge = q.bdry.get((qEdgeTracker)%q.bdry.size());
          }
        }
        //DONE
      }
      else {
          qEdgeTracker++;
          qEdge = q.bdry.get((qEdgeTracker)%q.bdry.size());
      }
    }
    if (aim(pEdge,qEdge) && !aim(qEdge,pEdge)){
      print("p points at q\n advance p\n");
      if (q.pointInPolygon(pEdge.p1)){
        print("add p to intersection");
        //ARRAY POINT SIZE CHECK DONE
        if (ipoints.size() < 1){
          ipoints.add(pEdge.p1);
          pEdgeTracker++;
          pEdge = p.bdry.get((pEdgeTracker)%p.bdry.size());
        }
        else{
          if (pEdge.p1 == ipoints.get(0)) {
            print("point is equal to starting point");
            flag = false;
          } 
          else {
            ipoints.add(pEdge.p1);
            pEdgeTracker++;
            pEdge = p.bdry.get((pEdgeTracker)%p.bdry.size());
          }
        }
        //DONE
      }
      else {
          pEdgeTracker++;
          pEdge = p.bdry.get((pEdgeTracker)%p.bdry.size());
      }
    }
    if (!aim(pEdge,qEdge) && !aim(qEdge,pEdge)){
      print("They do not point at each other.\n");
       if (pEdge.intersectionTest(qEdge) || qEdge.intersectionTest(pEdge)) {
    print("intersect\n");
    Point inPoint = pEdge.intersectionPoint(qEdge);
    
    //POINT ARRAY SIZE CHECK DONE
    if (ipoints.size() < 1){
      ipoints.add(inPoint);
      //advance p
      pEdgeTracker++;
      pEdge = p.bdry.get((pEdgeTracker)%p.bdry.size());
    }
    else {
      if (inPoint == ipoints.get(0)) {
        print("point is equal to starting point");
        flag = false;
      } 
      else {
        //check if inside p or q?
        if (q.pointInPolygon(pEdge.p1)){
          ipoints.add(pEdge.p1);
        }
        if (p.pointInPolygon(qEdge.p1)) {
          ipoints.add(qEdge.p1);
        }
        ipoints.add(inPoint);

        if (onHalfPlane(pEdge,qEdge)){
          print("advance p\n");
          pEdgeTracker++;
          pEdge = p.bdry.get((pEdgeTracker)%p.bdry.size());
        }
        else{
          print("advance q\n");
          qEdgeTracker++;
          qEdge = q.bdry.get((qEdgeTracker)%q.bdry.size());
        }
      }
    }
    //DONE
  }
      if (onHalfPlane(pEdge,qEdge)){
        print("advance p\n");
        pEdgeTracker++;
        pEdge = p.bdry.get((pEdgeTracker)%p.bdry.size());
      }
      else{
        print("advance q\n");
        qEdgeTracker++;
        qEdge = q.bdry.get((qEdgeTracker)%q.bdry.size());
      }
    }
  }
  loopCount++;
 }
 print(ipoints.size());
  return intersectionPoly;
  
}*/
