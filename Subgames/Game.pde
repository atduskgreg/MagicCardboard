import java.awt.Rectangle;

class Game {
  ArrayList<Token> tokens;
  Rectangle rect;
  color bg;

  Game(int x, int y, int w, int h) {
    setup();
    setPosition(x, y, w, h);
    bg = color(255);
  }
  
  void mousePressed(int x, int y){
    if(contains(x,y)){
      
       boolean onToken = false;
       for(Token token : tokens){
         if(token.contains(x - rect.x,y - rect.y)){
           onToken = true;
         }
       }
       if(!onToken){
         addToken(x - rect.x,y - rect.y);
       } else {
         println("on token");
       }
    }
  }
  
  void mouseDragged(int px, int py, int x, int y){
    // drag away?
    if(contains(px,py) && contains(x,y)){
       for(Token token : tokens){
         token.drag(px - rect.x ,py - rect.y,x - rect.x,y - rect.y);
       }
    }
  }

  void addToken(float tx, float ty){
    tokens.add(new Token(tx,ty));
  }

  boolean contains(int x, int y){
    return rect.contains(x,y);
  }
  
  void setup() {
    tokens = new ArrayList<Token>();
  }

  void setPosition(int x, int y, int w, int h) {
    rect = new Rectangle(x,y,w,h);
  }

  void draw() {
    pushMatrix();
    translate(rect.x, rect.y);

    pushStyle();
    fill(bg);
    stroke(0);
    rect(0, 0, rect.width, rect.height);
    popStyle();

    fill(0);stroke(0);
    text("tokens: " + tokens.size(), 20,20);

    for (Token token : tokens) {
      token.draw();
    }
    
    popMatrix();
  }
}

