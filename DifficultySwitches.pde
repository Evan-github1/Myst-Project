public class DifficultySwitches extends Switches {
  String difficulty, maxDifficulty;

  public DifficultySwitches(int switchX, int switchY, int switchW, int switchH) {
    // inherit the constructor variables from Switches class
    super(switchX, switchY, switchW, switchH);
    // default difficulty
    difficulty = "Easy";
    maxDifficulty = "Easy";
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
    text("Difficulty Mode: " + difficulty, x, y + h);
  }
   
  void detectDifficulty() {
    
    if ((sliderX - sliderW/2) >= (x - w/3 - w/6) && (sliderX + sliderW/2) <= (x - w/3 + w/6) && (maxDifficulty == "Easy" || maxDifficulty == "Medium" || maxDifficulty == "Hard")) {
      difficulty = "Easy";
    } else if ((sliderX - sliderW/2) >= (x - w/6) && (sliderX + sliderW/2) <= (x + w/6) && (maxDifficulty == "Medium" || maxDifficulty == "Hard")){
      difficulty = "Medium";
    } else if ((sliderX - sliderW/2) >= (x + w/3 - w/6) && (sliderX + sliderW/2) <= (x + w/3 + w/6) && maxDifficulty == "Hard"){
      difficulty = "Hard";
    }
  }
}
