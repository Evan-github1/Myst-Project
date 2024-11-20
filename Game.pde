public class Game {
  int score, timer, maxScore, maxTime, scoreSlideTimer;
  Game(int gameTimer) {
    score = 0;
    timer = 0;
    maxScore = 0;
    scoreSlideTimer = 0;
    maxTime = gameTimer; // in seconds
    maxTime *= 60; // changes into frames, can also be used as total amount of points
  }
  
  public void showScore() {
    // marking on the screen to show last and highest scores
    rectMode(CENTER);
    fill(backgroundColorSwitchR.returnColorValue() + 40, backgroundColorSwitchG.returnColorValue() + 40, backgroundColorSwitchB.returnColorValue() + 40);
    rect(200, 150, 200, 300);
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(0, 0, 0);
    text("Last \n Score: " + score, 200, 100);
    text("High \n Score: " + maxScore, 200, 200);
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
