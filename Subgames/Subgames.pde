Game[] games;

void setup() {
  size(800, 800);
  games = new Game[3];
  games[0] = new ContainGame("Contain", 0, 0, width/2, height/2);
  games[1] = new Game("Other", width/2, 0, width/2, height/2);
  InvestGame ig = new InvestGame("Invest", width/2, height/2, width/2, height/2);

  ig.addGame(games[0]);
  ig.addGame(games[1]);
  games[2] = ig;
}

void draw() {
  background(255);
  for (int i = 0; i < games.length; i++) {
    games[i].draw();
  }
}

void mouseDragged() {
  for (int i = 0; i < games.length; i++) {
    games[i].mouseDragged(pmouseX, pmouseY, mouseX, mouseY);
  }
}

void mousePressed() {
  for (int i = 0; i < games.length; i++) {
    games[i].mousePressed(mouseX, mouseY);
  }
}

void keyPressed() {
  for (int i = 0; i < games.length; i++) {
    games[i].keyPressed(key);
  }
}


PVector getDistance(PVector p, float x1, float y1, float x2, float y2 ) {
  PVector result = new PVector(); 

  float dx = x2 - x1; 
  float dy = y2 - y1; 
  float d = sqrt( dx*dx + dy*dy ); 
  float ca = dx/d; // cosine
  float sa = dy/d; // sine 

  float mX = (-x1+p.x)*ca + (-y1+p.y)*sa; 

  if ( mX <= 0 ) {
    result.x = x1; 
    result.y = y1;
  }
  else if ( mX >= d ) {
    result.x = x2; 
    result.y = y2;
  }
  else {
    result.x = x1 + mX*ca; 
    result.y = y1 + mX*sa;
  }

  dx = p.x - result.x; 
  dy = p.y - result.y; 
  result.z = sqrt( dx*dx + dy*dy ); 

  return result;
}

