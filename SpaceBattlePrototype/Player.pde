class Player {
  PVector pos;
  color c;
  String name;
  boolean dead = false;
  
  Player(){}
  
  Player(String name, int x, int y){
    this.pos = new PVector(x,y);
    this.c = color(random(255), random(255), random(255));
    this.name = name;
  }  
  
  void die(){
    this.dead = true;
  }
  
  color getColor(){
    return c;
  }
  
  boolean checkHits(ArrayList<Missile> missiles){
    boolean result = false;
    for(Missile missile : missiles){
      if(PVector.dist(missile.pos, this.pos)< 25){
        result = true;
        break;
      } 
    }
    return result;
  }
  
  void move(int moveDir){
    switch(moveDir){
      case UP:
        pos.y -= 50;
        break;
      case DOWN:
        pos.y += 50;
        break;
      case LEFT:
        pos.x -= 50;
        break;
      case RIGHT:
        pos.x += 50;
        break;
    }
  }
  
  void draw(boolean isCurrent){
  
    pushMatrix();
    pushStyle();
    
    if(isCurrent){
      fill(125);
    } else{
      fill(0);
    }
    
    if(dead){
      fill(255,0,0);
    }
    
    strokeWeight(4);
    stroke(c);
    ellipse(pos.x,pos.y, 50, 50);
    
    if(isCurrent){
      stroke(0);
      fill(0);
    }
    fill(255);
    text(name, pos.x-3,pos.y+5);
    
    popStyle();
    popMatrix();
  }
}
