import java.util.Iterator;
class ContainGame extends Game {
  ArrayList<Barrier> barriers;

  ContainGame(int x, int y, int w, int h) {
    super(x, y, w, h);

    barriers = new ArrayList<Barrier>();

    Enemy e = new Enemy((int)random(w), (int)random(h));
    e.setGoal(w, h);
    enemies.add(e);
  }

  void onNewToken(Token token) {
    if (tokens.size() > 1) {
      Token fromToken = tokens.get(tokens.size() - 2);
      barriers.add(new Barrier(fromToken.pos, token.pos));
    }
  }
  
  void drawEnemies(){
    for(Enemy enemy : enemies){
      enemy.update();
      enemy.checkBarriers(barriers);
      enemy.draw();
    }
    
    for(Iterator<Enemy> iterator = enemies.iterator(); iterator.hasNext();){
      Enemy enemy = iterator.next();
      if(enemy.isDead()){
        iterator.remove();
      }
    }
  }
  
  void removeDeadBarriers(){
    for(Iterator<Barrier> iterator = barriers.iterator(); iterator.hasNext();){
      Barrier barrier = iterator.next();
      if(barrier.isDead()){
        iterator.remove();
      }
    }
  }

  void draw() {
    pushMatrix();
    translate(rect.x, rect.y);

    pushStyle();
    fill(255);
    stroke(0);
    rect(0, 0, rect.width, rect.height);
    popStyle();

    fill(0);
    stroke(0);
    text("tokens: " + tokens.size(), 20, 20);
    drawEnemies();
    removeDeadBarriers();

    for(Barrier barrier : barriers){
      barrier.draw();
    }

    for (Token token : tokens) {
      token.draw();
    }

    popMatrix();
  }
}

