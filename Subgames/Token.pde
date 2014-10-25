import java.awt.Rectangle;

class Token {
  PVector pos;
  int size;
  
  Token(float x, float y){
    pos = new PVector(x,y);
    size = 20;
  }
  
  void draw(){
    pushMatrix();
    pushStyle();
    
    fill(0);
    noStroke();
    ellipse(pos.x,pos.y, size,size);
    
    popStyle();
    popMatrix();
  }
  
  boolean contains(int x, int y){
    Rectangle r = new Rectangle((int)pos.x - size/2, (int)pos.y - size/2, size, size);
    return r.contains(x,y);
  }
  
  void drag(int px, int py, int x, int y){
    if(contains(px,py)){
      pos.x = x;
      pos.y = y;
    }
  }
  
}
