class Turn{
  boolean fired = false;
  boolean moved = false;
  boolean scanned = false;
  int num;
  int numPlayers;
  int actionsPerTurn;
  int actionsTaken;
  
  Turn(int numPlayers){
    this.num = 0;
    this.numPlayers = numPlayers;
    this.actionsTaken = 0;
  }
  
  void setNumActions(int n){
    actionsPerTurn = n;
  }
  
  void takeAction(){
    actionsTaken++;
  }
  
  int actionsRemaining(){
    return actionsPerTurn - actionsTaken;
  }
 
  int playerNum(){
    return this.num;
  }
  
  void next(){
    actionsTaken = 0;
    num++;
    if(num > numPlayers-1){
      num = 0;
    }
  }
  
  boolean isComplete(){
    return actionsRemaining() <= 0;
  }

}
