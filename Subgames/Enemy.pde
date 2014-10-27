class Enemy{
  PVector pos;
  PVector goal;
  float speed;
  PVector dir;
  int hitPoints;
  
  Enemy(int x, int y){
    pos = new PVector(x,y);
    speed = 1;
    dir = new PVector(random(-1,1), random(-1,1));
    hitPoints = 3;
  }
  
  void setSpeed(float s){
    speed = s;
  }
  
  void setGoal(int x , int y){
    goal = new PVector(x,y);
  }
  
  void update(){
    PVector toGoal = PVector.sub(goal, pos);
    toGoal.normalize();
    
    // turn around faster when near goal to discourage goal blocking
    float dToGoal = pos.dist(goal);
    float m = map(dToGoal, 0, 50, 0.5, 0.1);
    
    toGoal.mult(constrain(m, 0.1, 0.5));
    
    dir.normalize();
    dir.add(toGoal);
    dir.mult(speed); 
    pos.add(dir); 
  }
  
  boolean isDead(){
    return hitPoints <= 0;
  }
  
  void checkBarriers(ArrayList<Barrier> barriers){
    for(Barrier barrier : barriers){
      PVector d = getDistance(pos, barrier.from.x, barrier.from.y, barrier.to.x, barrier.to.y);
      println(d.z);
      if(d.z < 1){
        // collision
        barrier.hit();
        dir.mult(-1);
        pos.add(dir);
        hitPoints--;
      }
    }

    float d = PVector.dist(pos, goal);
    if(d < 1){
      hitPoints=  0;
    }
    
  }
  
  void draw(){
    pushMatrix();
    pushStyle();
    noFill();
    stroke(0);
    strokeWeight(1);
    
    translate(pos.x,pos.y);
    rotate(dir.heading2D());
    
    beginShape();
    float arrowsize = 10;
    vertex(0,0);
    vertex(-arrowsize, arrowsize/2);
    vertex(-arrowsize, -arrowsize/2);
    endShape(CLOSE);

    popStyle();
    popMatrix();
  }
  

}
