Buttons play, htp, trackingButton, back, trackingStart, settings, restoreDefault;
DifficultySwitches trackingSwitch;
RGBSwitches backgroundColorSwitchR, backgroundColorSwitchG, backgroundColorSwitchB;
Game tracking;
Target trackingTarget;
String screen = "mainscreen";
int windupTimer = 0;
public void setup() {
  size(1100, 750);
  // buttons
  play = new Buttons(550, 250, 200, 100, "PLAY");
  htp = new Buttons(550, 400, 350, 100, "HOW TO PLAY");
  trackingButton = new Buttons(550, 250, 250, 100, "TRACKING");
  back = new Buttons(1050, 700, 50, 50, "BACK");
  trackingStart = new Buttons(550, 550, 200, 100, "START");
  settings = new Buttons(550, 550, 250, 100, "SETTINGS");
  restoreDefault = new Buttons(550, 600, 350, 100, "RESTORE DEFAULT");

  // switches
  trackingSwitch = new DifficultySwitches(550, 300, 300, 100);
  backgroundColorSwitchR = new RGBSwitches(550, 275, 765, 50, 74);
  backgroundColorSwitchG = new RGBSwitches(550, 375, 765, 50, 110);
  backgroundColorSwitchB = new RGBSwitches(550, 475, 765, 50, 229);


  // games
  tracking = new Game(20);
  
  // targets
  trackingTarget = new Target(550, 375, 50, 50, 3, 3);
  
  textAlign(CENTER, CENTER);
}

public void draw() {
  background(backgroundColorSwitchR.returnColorValue(), backgroundColorSwitchG.returnColorValue(), backgroundColorSwitchB.returnColorValue());

  // changes screen
  switch (screen) {
  case "mainscreen":
    mainScreen();
    break;
  case "playscreen":
    playScreen();
    break;
  case "howtoplayscreen":
    howToPlayScreen();
    break;
  case "trackingstart":
    trackingStartScreen();
    break;
  case "settingsscreen":
    settingsScreen();
    break;
  case "trackinggame":
    targetGame();
    break;
  }

  //gun
  //rectMode(CENTER);
  //stroke(0, 0, 0);
  //fill(105, 105, 105);
  //rect(900, 650, 100, 200);
  //rect(900, 500, 100, 100);
}

public void mouseReleased() {
  // button presses
  // switches screens and disables buttons not relative to screen
  // (this means every if statement should have at mouseOverButton() and checkScreen(String) methods)
  if (play.mouseOverButton() && play.checkScreen("mainscreen")) {
      screen = "playscreen";
  } else if (htp.mouseOverButton() && htp.checkScreen("mainscreen")) {
      screen = "howtoplayscreen";
  } else if (trackingButton.mouseOverButton() && trackingButton.checkScreen("playscreen")) {
      screen = "trackingstart";
  } else if (settings.mouseOverButton() && settings.checkScreen("mainscreen")) {
      screen = "settingsscreen";
  } else if (trackingStart.mouseOverButton() && trackingStart.checkScreen("trackingstart")) {
      tracking.score = 0;
      tracking.timer = 0;
      trackingTarget.x = trackingTarget.FX;
      trackingTarget.y = trackingTarget.FY;
      
      if (trackingSwitch.difficulty == "Easy") {
       trackingTarget.w = trackingTarget.FW;
       trackingTarget.h = trackingTarget.FH;
       trackingTarget.dx = trackingTarget.FDX;
       trackingTarget.dy = trackingTarget.FDY;
       System.out.println(trackingTarget.FW);
     } else if (trackingSwitch.difficulty == "Medium") {
       trackingTarget.w = trackingTarget.FW/1.5;
       trackingTarget.h = trackingTarget.FH/1.5;
       trackingTarget.dx = trackingTarget.FDX * 1.2;
       trackingTarget.dy = trackingTarget.FDY * 1.2;
     } else if (trackingSwitch.difficulty == "Hard") {
       trackingTarget.w = trackingTarget.FW/2;
       trackingTarget.h = trackingTarget.FH/2;
       trackingTarget.dx = trackingTarget.FDX * 1.5;
       trackingTarget.dy = trackingTarget.FDY * 1.5;
   }
   
      screen = "trackinggame";
  }
  
    else if (restoreDefault.mouseOverButton() && restoreDefault.checkScreen("settingsscreen")) {
      backgroundColorSwitchR.sliderX = 74 * 3 + backgroundColorSwitchR.x - backgroundColorSwitchR.w/2;
      backgroundColorSwitchG.sliderX = 110 * 3 + backgroundColorSwitchG.x - backgroundColorSwitchG.w/2;
      backgroundColorSwitchB.sliderX = 229 * 3 + backgroundColorSwitchB.x - backgroundColorSwitchB.w/2;
  }
  // previous screens buttons
  else if (back.mouseOverButton()) {
    if (back.checkScreen("playscreen") || back.checkScreen("howtoplayscreen") || back.checkScreen("settingsscreen")) {
      screen = "mainscreen";
    } else if (back.checkScreen("trackingstart")) {
      screen = "playscreen";
    } 
  }
}

public void mouseDragged() {
  if (trackingSwitch.checkScreen("trackingstart")) {
    trackingSwitch.dragSlider();
  } else if (backgroundColorSwitchR.checkScreen("settingsscreen") || backgroundColorSwitchG.checkScreen("settingsscreen") || backgroundColorSwitchB.checkScreen("settingsscreen")) {
    backgroundColorSwitchR.dragSlider();
    backgroundColorSwitchG.dragSlider();
    backgroundColorSwitchB.dragSlider();
  }
}


// different screens
public void mainScreen() {
  play.drawButton();
  htp.drawButton();
  settings.drawButton();
  textSize(50);
  fill(0, 0, 0);
  // rainbow if you hover over the title? pulsing animation w/ title?
  text("Precision Pulse", 550, 100);
}

public void playScreen() {
  trackingButton.drawButton();
  back.drawButton();
  textSize(50);
  fill(0, 0, 0);
  text("Games", 550, 100);
}

public void howToPlayScreen() {
  back.drawButton();
  textSize(50);
  fill(0, 0, 0);
  text("How to Play?", 550, 100);
  textSize(30);
  text("Precision Pulse is a game to train your aim in FPS games! \n FOR THE BEST EXPERIENCE, USE A MOUSE! \n\n Press PLAY on the main screen to be introduced to different courses. \n Each course's difficulty can be toggled after completing the first mode. \n\n This project is greatly inspired by popular aim trainer AimLabs. \n Made by Evan Xiang.", 550, 300);
}

public void trackingStartScreen() {
  back.drawButton();
  textSize(50);
  fill(0, 0, 0);
  text("Tracking", 550, 100);
  trackingSwitch.drawSwitch();
  trackingSwitch.detectDifficulty();
  trackingStart.drawButton();
}

public void settingsScreen() {
  backgroundColorSwitchR.drawSwitch();
  backgroundColorSwitchG.drawSwitch();
  backgroundColorSwitchB.drawSwitch();
  back.drawButton();
  restoreDefault.drawButton();
  textSize(50);
  fill(0, 0, 0);
  text("Settings", 550, 100);
  text("R:", backgroundColorSwitchR.x - backgroundColorSwitchR.w/1.8, backgroundColorSwitchR.y);
  text("G:", backgroundColorSwitchG.x - backgroundColorSwitchG.w/1.8, backgroundColorSwitchG.y);
  text("B:", backgroundColorSwitchB.x - backgroundColorSwitchB.w/1.8, backgroundColorSwitchB.y);
}

public void targetGame() {
   textSize(50);
   fill(0, 0, 0);
   text("Score: " + tracking.score, 550, 100);
   text("Max Score: " + tracking.maxScore, 550, 150);

   trackingTarget.drawTarget();
   tracking.timer++;
   if (tracking.checkTimeLimit()) {
     tracking.detectMaxScore();
     if (trackingSwitch.maxDifficulty == "Easy" && tracking.score > 0) {
       trackingSwitch.maxDifficulty = "Medium";
     } else if (trackingSwitch.maxDifficulty == "Medium" && tracking.score > 0) {
       trackingSwitch.maxDifficulty = "Hard";
     }
     System.out.println("Final Score: " + tracking.score + "/" + tracking.maxTime);

     screen = "trackingstart";
     tracking.timer = 0;

   }
   if (mousePressed && trackingTarget.mouseOverTarget() && trackingTarget.checkScreen("trackinggame")) {
     tracking.score++;
   }
   System.out.println(tracking.score);
}

//public void windup(String nextScreen) {
//    textSize(50);
//    fill(0, 0, 0);
//    windupTimer++;
//    if (windupTimer <= 60) {
//      text("3", 550, 100);
//    } else if (120 >= windupTimer && windupTimer > 60) {
//      text("2", 550, 100);
//    } else if (180 >= windupTimer && windupTimer > 121) {
//      text("1", 550, 100);
//    } else if (240 >= windupTimer && windupTimer > 181) {
//      text("GO!", 550, 100);
//    } else if (240 < windupTimer) {
//      windupTimer = 0;
//      screen = nextScreen;
//    }
//}
