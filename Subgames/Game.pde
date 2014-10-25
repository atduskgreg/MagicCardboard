import java.awt.Rectangle;

class Game {
  ArrayList<Token> tokens;
  Rectangle rect;
  ArrayList<Enemy> enemies;
  String name;

  Game(String name, int x, int y, int w, int h) {
    setup();
    setPosition(x, y, w, h);
    this.name = name;
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
       }
    }
  }
  
  void keyPressed(char k){
    // do something
  }
 
  
  void mouseDragged(int px, int py, int x, int y){
    // drag away?
    if(contains(px,py) && contains(x,y)){
       for(Token token : tokens){
         token.drag(px - rect.x ,py - rect.y,x - rect.x,y - rect.y);
       }
    }
  }
  
  void drawEnemies(){
    for(Enemy enemy : enemies){
      enemy.update();
      enemy.draw();
    }
  }

  void onNewToken(Token t){
    // implemented in sublcasses
  }

  void addToken(float tx, float ty){
    Token t =  new Token(tx,ty);
    tokens.add(t);
    onNewToken(t);
  }
  
 

  boolean contains(int x, int y){
    return rect.contains(x,y);
  }
  
  void setup() {
    tokens = new ArrayList<Token>();
    enemies = new ArrayList<Enemy>();
  }

  void setPosition(int x, int y, int w, int h) {
    rect = new Rectangle(x,y,w,h);
  }

  //implement in subclass
  void innerDraw(){}

  void draw() {
    pushMatrix();
    translate(rect.x, rect.y);

    pushStyle();
    fill(255);
    stroke(0);
    rect(0, 0, rect.width, rect.height);
    popStyle();

    fill(0);stroke(0);
    text("tokens: " + tokens.size(), 20,20);

    pushStyle();
    pushMatrix();
    innerDraw();
    popMatrix();
    popStyle();

    for (Token token : tokens) {
      token.draw();
    }
    
    
    popMatrix();
  }
}

