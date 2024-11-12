public class Game {
  int score, timer, maxScore, maxTime;
  Game(int gameTimer) {
    score = 0;
    timer = 0;
    maxScore = 0;
    maxTime = gameTimer; // in seconds
    maxTime *= 60; // changes into frames, can also be used as total amount of points
  }
  
  // timer
  public boolean checkTimeLimit() {
    if (timer >= maxTime) {
      return true;
    } else {
      return false;
    }
  }
  // score
  public void detectMaxScore() {
    if (score > maxScore) {
      maxScore = score;
    }
  }
  
}
