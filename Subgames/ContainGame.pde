import java.util.Iterator;
class ContainGame extends Game {
  ArrayList<Barrier> barriers;

  ContainGame(String name, int x, int y, int w, int h) {
    super(name, x, y, w, h);

    barriers = new ArrayList<Barrier>();

//    Enemy e = new Enemy((int)random(w), (int)random(h));
//    e.setGoal(w, h);
//    enemies.add(e);
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
  }
  
  void removeDeadEnemies(){
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
  
  void keyPressed(char k){
    if(k == 'e'){
      addEnemy();
    }
  }

  void innerDraw() {
    drawEnemies();
    removeDeadEnemies();
    removeDeadBarriers();

    for(Barrier barrier : barriers){
      barrier.draw();
    }
  }
}

