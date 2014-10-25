class InvestGame extends Game { 
  ArrayList<Game> games;
  HashMap<Game, Rectangle> gameTargets;
 
  InvestGame(String name, int x, int y, int w, int h) {
    super(name, x, y, w, h);
    
    games = new ArrayList<Game>();
    gameTargets = new HashMap<Game,Rectangle>();
  }
  
  void addGame(Game game){
    games.add(game);    
    gameTargets.put(game, new Rectangle(0,0, 150, 150));
  }
  
  int tokenCount(Game game){
    Rectangle r = gameTargets.get(game);
    int result = 0;
    for(Token token : tokens){
      if(r.contains(token.pos.x, token.pos.y)){
        result ++;
      }
    }
    return result;
  }
  
  void innerDraw(){
    noFill();
    stroke(0);
    int x = 50;
    int y = 50;
    for(Game game : games){
      Rectangle rect = gameTargets.get(game);
      rect.x = x;
      rect.y = y;
      
      rect(x,y, rect.width, rect.height);
      text(game.name + ": " + tokenCount(game), x, y + rect.height + 15);
      
      x += (rect.width + 25);
    }
  }
   
   
}
