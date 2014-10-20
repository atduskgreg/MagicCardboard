class Turn{
  boolean fired = false;
  boolean moved = false;
  boolean scanned = false;
  int num;
  int numPlayers;
  
  Turn(int numPlayers){
    this.num = 0;
    this.numPlayers = numPlayers;
  }
  
  boolean hasFired(){
    return fired;
  }
  
  boolean hasMoved(){
    return moved;    
  }
  
  boolean hasScanned(){
    return scanned;
  }
  
  int playerNum(){
//    println("pn: " + this.num);
    return this.num;
  }
  
  void fire(){
    fired = true;
  }
  
  void move(){
    moved = true;
  }
  
  void scan(){
    scanned = true;
  }
  
  void next(){
    fired = false;
    moved = false;
    scanned = false;
    num++;
    if(num > numPlayers-1){
      num = 0;
    }
  }
  
  boolean isComplete(){
    return moved && fired && scanned;
    
  }

}
