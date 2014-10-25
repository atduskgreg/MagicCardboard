Game[] games;

void setup() {
  size(800, 800);
  games = new Game[3];
  games[0] = new ContainGame(0, 0, width/2, height/2);
  games[1] = new Game(width/2, 0, width/2, height/2);
  games[2] = new Game(width/2, height/2, width/2, height/2);
}

void draw() {
  background(255);
  for (int i = 0; i < games.length; i++) {
    games[i].draw();
  }
}

void mouseDragged(){
  for (int i = 0; i < games.length; i++) {
    games[i].mouseDragged(pmouseX, pmouseY,mouseX, mouseY);
  }
}

void mousePressed(){
  for (int i = 0; i < games.length; i++) {
    games[i].mousePressed(mouseX, mouseY);
  }
  
}

