class Missile{
  PVector pos;
  PVector dir;
  int speed = 50;
  Player owner;
  float angle;
  
  Missile(float x, float y, PVector dir, Player owner){
    pos = new PVector(x,y);
    this.dir = new PVector(dir.x, dir.y);
    
    println(dir.x +","+ dir.y);
    this.owner = owner;
    
    angle = PVector.angleBetween(dir, new PVector(0,1));
  }
  
  void move(){
    pos.x += dir.x * 50;
    pos.y += dir.y * 50;
  }
  
  void draw(){
    pushMatrix();
    pushStyle();
    
    translate(pos.x,pos.y);
    
    if(dir.x < 0 ){
      rotate(angle);
    } else {
      rotate(-angle);
    }
    
    fill(255);
    rect(0,0, 5, 20);
    
    fill(255,20,20);

//    if(dir.y > 0){
      rect(0,0,5,5);
//    } else {
//      rect(0, 20,5,5);
//    }
    popStyle();
    popMatrix();
  }
}
