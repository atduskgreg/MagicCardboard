class ContainGame extends Game {
  ContainGame(int x, int y, int w, int h) {
    super(x, y, w, h);
  }

  void draw() {
    pushMatrix();
    translate(rect.x, rect.y);

    pushStyle();
    fill(bg);
    stroke(0);
    rect(0, 0, rect.width, rect.height);
    popStyle();

    fill(0);
    stroke(0);
    text("tokens: " + tokens.size(), 20, 20);
    
    
    noFill();
    strokeWeight(2);
    stroke(255,0,0);
    beginShape();
    
    for (Token token : tokens) {
      vertex(token.pos.x, token.pos.y);
    }
    
    endShape(CLOSE);


    for (Token token : tokens) {
      token.draw();
    }

    popMatrix();
  }
}

