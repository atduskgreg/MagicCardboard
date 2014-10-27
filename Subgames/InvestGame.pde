class InvestGame extends Game { 
  ArrayList<Game> games;
  HashMap<Game, Rectangle> gameTargets;

  InvestGame(String name, int x, int y, int w, int h) {
    super(name, x, y, w, h);

    games = new ArrayList<Game>();
    gameTargets = new HashMap<Game, Rectangle>();
  }

  void keyPressed(char k) {
    if (k == 'r') {
      generateEnemies();
    }
  }

  void addGame(Game game) {
    games.add(game);    
    gameTargets.put(game, new Rectangle(0, 0, 150, 150));
  }

  int tokenCount(Game game) {
    Rectangle r = gameTargets.get(game);
    int result = 0;
    for (Token token : tokens) {
      if (r.contains(token.pos.x, token.pos.y)) {
        result ++;
      }
    }
    return result;
  }

  void generateEnemies() {
     int maxGen = 5;
    
    ArrayList<Float> percentages = new ArrayList<Float>();

    for (Game game : games) {
      int c = tokenCount(game);
      float p = max((maxGen-c), 0)/float(maxGen);
      percentages.add(p);
    }

    for (int i = 0; i < 5; i++) {
      for (int g = 0; g < games.size(); g++) {
        float r = random(1);
        if (r < percentages.get(g)) {
          games.get(g).addEnemy();
        }
      }
    }
  }

  void innerDraw() {
    noFill();
    stroke(0);
    int x = 50;
    int y = 50;
    for (Game game : games) {
      Rectangle rect = gameTargets.get(game);
      rect.x = x;
      rect.y = y;

      rect(x, y, rect.width, rect.height);
      text(game.name + ": " + tokenCount(game), x, y + rect.height + 15);

      x += (rect.width + 25);
    }
  }
}

