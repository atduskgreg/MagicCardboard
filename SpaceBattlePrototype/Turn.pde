class Turn{
  int player;
  int numPlayers;
  int actionsPerTurn;
  int actionsTaken;
  
  Turn(int numPlayers){
    this.player = 0;
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
    return this.player;
  }
  
  void next(){
    actionsTaken = 0;
    player++;
    if(player > numPlayers-1){
      player = 0;
    }
  }
  
  boolean isComplete(){
    return actionsRemaining() <= 0;
  }

}
