class Enemy{
  PVector pos;
  PVector goal;
  float speed;
  PVector dir;
  boolean dead;
  
  Enemy(int x, int y){
    pos = new PVector(x,y);
    speed = 1;
    dir = new PVector();
    dead = false;
  }
  
  void setSpeed(float s){
    speed = s;
  }
  
  void setGoal(int x , int y){
    goal = new PVector(x,y);
  }
  
  void update(){
    dir = PVector.sub(goal, pos);
    dir.normalize();
    dir.mult(speed); 
    pos.add(dir); 
  }
  
  boolean isDead(){
    return dead;
  }
  
  void checkBarriers(ArrayList<Barrier> barriers){
    for(Barrier barrier : barriers){
      PVector d = getDistance(pos, barrier.from.x, barrier.from.y, barrier.to.x, barrier.to.y);
      println(d.z);
      if(d.z < 1){
        // collision
        barrier.hit();
        setSpeed(0);
        dead = true;
      }
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
