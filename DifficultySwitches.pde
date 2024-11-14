public class DifficultySwitches extends Switches {
  String difficulty, maxDifficulty;
  int reqScore;

  public DifficultySwitches(int switchX, int switchY, int switchW, int switchH, int requiredScore) {
    // inherit the constructor variables from Switches class
    super(switchX, switchY, switchW, switchH);
    // default difficulty
    difficulty = "Easy";
    maxDifficulty = "Easy";
    
    reqScore = requiredScore;
  }

  public void drawSwitch() {
    rectMode(CENTER);
    noStroke();
    
    // easy
    fill(50, 205, 50);
    rect(x - w/3, y, w/3, h);
    // medium
    fill(255, 215, 0);
    rect(x, y, 100, h);
    // hard
    fill(220, 20, 60);
    rect(x + w/3, y, w/3, h);
    
    // slider
    fill(255, 255, 255);
    rect(sliderX, sliderY, sliderW, sliderH);
    
    fill(0, 0, 0);
    textSize(50);
    text("Difficulty Mode: " + difficulty, x, y + h);
  }
   
  protected void detectDifficulty() {
    if ((sliderX - sliderW/2) >= (x - w/3 - w/6) && (sliderX + sliderW/2) <= (x - w/3 + w/6) && (maxDifficulty == "Easy" || maxDifficulty == "Medium" || maxDifficulty == "Hard")) {
      difficulty = "Easy";
    } else if ((sliderX - sliderW/2) >= (x - w/6) && (sliderX + sliderW/2) <= (x + w/6)){
      if ((maxDifficulty == "Medium" || maxDifficulty == "Hard")) {
        difficulty = "Medium";
      } else {
        text("Get " + reqScore + " on Easy to Unlock Medium!", x, y + 1.5 * h);
      }
    } else if ((sliderX - sliderW/2) >= (x + w/3 - w/6) && (sliderX + sliderW/2) <= (x + w/3 + w/6)){
      if (maxDifficulty == "Hard") {
        difficulty = "Hard";
      } else {
        text("Get " + reqScore + " on Medium to Unlock Hard!", x, y + 1.5 * h);
      }
    }
  }
}
