class Barrier {
  PVector from;
  PVector to;
  int hitPoints;
  
  Barrier(PVector p1, PVector p2){
    from = p1;
    to = p2;
    hitPoints = 3;
  }
  
  void hit(){
    hitPoints--;
  }
  
  boolean isDead(){
    return hitPoints <= 0;
  }
  
  void draw(){
    pushStyle();
    strokeWeight(hitPoints);
    stroke((255/3.0)*hitPoints,0,0, (255/3.0)*hitPoints);
    line(from.x, from.y, to.x, to.y);
    popStyle();
  }
}
