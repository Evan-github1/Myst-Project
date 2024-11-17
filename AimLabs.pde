Buttons play, htp, trackingButton, back, start, settings, restoreDefault, flickingButton;
DifficultySwitches trackingSwitch, flickingSwitch;
RGBSwitches backgroundColorSwitchR, backgroundColorSwitchG, backgroundColorSwitchB;
Game tracking, flicking;
Target trackingTarget;
Bot flickingTarget;
String screen = "mainscreen";
int windupTimer = 0;
int flickingDelay = 0;

public void setup() {
  size(1100, 750);
  // buttons
  play = new Buttons(550, 250, 200, 100, "PLAY");
  htp = new Buttons(550, 400, 350, 100, "HOW TO PLAY");
  trackingButton = new Buttons(550, 250, 250, 100, "TRACKING");
  back = new Buttons(1050, 700, 50, 50, "BACK");
  start = new Buttons(550, 550, 200, 100, "START");
  settings = new Buttons(550, 550, 250, 100, "SETTINGS");
  restoreDefault = new Buttons(550, 600, 350, 100, "RESTORE DEFAULT");
  flickingButton = new Buttons(550, 400, 250, 100, "FLICKING");

  // switches
  trackingSwitch = new DifficultySwitches(550, 300, 300, 100, 400);
  flickingSwitch = new DifficultySwitches(550, 300, 300, 100, 900);
  backgroundColorSwitchR = new RGBSwitches(550, 275, 765, 50, 74);
  backgroundColorSwitchG = new RGBSwitches(550, 375, 765, 50, 110);
  backgroundColorSwitchB = new RGBSwitches(550, 475, 765, 50, 229);

  // games
  tracking = new Game(20);
  flicking = new Game(30);
  
  // targets
  trackingTarget = new Target(550, 375, 50, 50, 3, 3);
  flickingTarget = new Bot(550, 375, 10, 10, 0, 0);
  
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
    startScreen();
    break;
  case "settingsscreen":
    settingsScreen();
    break;
  case "trackinggame":
    trackingGame();
    break;
  case "flickingstart":
    flickingStartScreen();
    break;
  case "flickinggame":
    flickingGame();
    break;
  }
}

public void mouseReleased() {
  // button presses
  // switches screens and disables buttons not relative to screen
  // (this means every if statement should have at mouseOverButton() and checkScreen(String) methods)
  if (play.mouseOverButton() && play.checkScreen("mainscreen")) {
      // different games screen
      screen = "playscreen";
  } else if (htp.mouseOverButton() && htp.checkScreen("mainscreen")) {
      // how to play screen
      screen = "howtoplayscreen";
  } else if (trackingButton.mouseOverButton() && trackingButton.checkScreen("playscreen")) {
      // tracking starting screen
      screen = "trackingstart";
  } else if (settings.mouseOverButton() && settings.checkScreen("mainscreen")) {
      // settings screen
      screen = "settingsscreen";
  } else if (flickingButton.mouseOverButton() && trackingButton.checkScreen("playscreen")) {
      screen = "flickingstart";
  } else if (flickingButton.mouseOverButton() && trackingButton.checkScreen("playscreen")) {
      screen = "trackingstart";
  } else if (start.checkScreen("trackingstart") && start.mouseOverButton()) {
      // tracking game
      // resets things
      tracking.score = 0;
      tracking.timer = 0;
      trackingTarget.x = trackingTarget.FX;
      trackingTarget.y = trackingTarget.FY;
      
      // detects diffculty
      if (trackingSwitch.difficulty == "Easy") {
         trackingTarget.w = trackingTarget.FW;
         trackingTarget.h = trackingTarget.FH;
         trackingTarget.dx = trackingTarget.FDX;
         trackingTarget.dy = trackingTarget.FDY;
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
  } else if (start.checkScreen("flickingstart") && start.mouseOverButton()) {
      // resets things
      flicking.score = 0;
      flicking.timer = 0;
      flickingTarget.x = flickingTarget.FX;
      flickingTarget.y = flickingTarget.FY;
      // detects diffculty
      //if (flickingSwitch.difficulty == "Easy") {
      //   flickingTarget.w = flickingTarget.FW;
      //   flickingTarget.h = flickingTarget.FH;
      // } else if (flickingSwitch.difficulty == "Medium") {
      //   flickingTarget.w = flickingTarget.FW/2;
      //   flickingTarget.h = flickingTarget.FH/2;
      // } else if (flickingSwitch.difficulty == "Hard") {
      //   flickingTarget.w = flickingTarget.FW/4;
      //   flickingTarget.h = flickingTarget.FH/4;
      //}
      screen = "flickinggame";
  } else if (restoreDefault.mouseOverButton() && restoreDefault.checkScreen("settingsscreen")) {
      backgroundColorSwitchR.sliderX = 74 * 3 + backgroundColorSwitchR.x - backgroundColorSwitchR.w/2;
      backgroundColorSwitchG.sliderX = 110 * 3 + backgroundColorSwitchG.x - backgroundColorSwitchG.w/2;
      backgroundColorSwitchB.sliderX = 229 * 3 + backgroundColorSwitchB.x - backgroundColorSwitchB.w/2;
  }
  // previous screens buttons
    else if (back.mouseOverButton()) {
    if (back.checkScreen("playscreen") || back.checkScreen("howtoplayscreen") || back.checkScreen("settingsscreen")) {
      screen = "mainscreen";
    } else if (back.checkScreen("trackingstart") || back.checkScreen("flickingstart")) {
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
  } else if (flickingSwitch.checkScreen("flickingstart")) {
    flickingSwitch.dragSlider();
  }
}


// different screens
public void mainScreen() {
  // home screen, aka the first screen you see
  play.drawButton();
  htp.drawButton();
  settings.drawButton();
  textSize(50);
  fill(0, 0, 0);
  // rainbow if you hover over the title? pulsing animation w/ title?
  text("Precision Pulse", 550, 100);
}

public void playScreen() {
  // all games screen
  trackingButton.drawButton();
  flickingButton.drawButton();
  back.drawButton();
  textSize(50);
  fill(0, 0, 0);
  text("Games", 550, 100);
}

public void howToPlayScreen() {
  // instructions and credit
  back.drawButton();
  textSize(50);
  fill(0, 0, 0);
  text("How to Play?", 550, 100);
  textSize(30);
  text("Precision Pulse is a game to train your aim in FPS games! \n FOR THE BEST EXPERIENCE, USE A MOUSE! \n\n Press PLAY on the main screen to be introduced to different courses. \n Each course's difficulty can be toggled after completing the first mode. \n\n This project is greatly inspired by popular aim trainer AimLabs. \n Made by Evan Xiang.", 550, 300);
}

public void startScreen() {
  // adjust difficulty and press start for tracking
  back.drawButton();
  textSize(50);
  fill(0, 0, 0);
  text("Tracking", 550, 100);
  trackingSwitch.drawSwitch();
  trackingSwitch.detectDifficulty();
  start.drawButton();
}

public void settingsScreen() {
  // change background color
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

public void trackingGame() {
   // actual tracking game
   textSize(50);
   fill(0, 0, 0);
   text("Score: " + tracking.score, 550, 100);
   text("Max Score: " + tracking.maxScore, 550, 150);

   trackingTarget.drawTarget();
   tracking.timer++;
   text("Time Left: " + (round((1200 - tracking.timer)/60)), 550, 200);
   
   // calculates everything once time limit is up
   if (tracking.checkTimeLimit()) {
     tracking.detectMaxScore();
     if (trackingSwitch.difficulty == "Easy" && tracking.score >= trackingSwitch.reqScore) {
       trackingSwitch.maxDifficulty = "Medium";
     } else if (trackingSwitch.difficulty == "Medium" && tracking.score >= trackingSwitch.reqScore) {
       trackingSwitch.maxDifficulty = "Hard";
     }
     // perhaps have a popup that gives you final score?
     System.out.println("Final Score: " + tracking.score + "/" + tracking.maxTime);
     // reset
     screen = "trackingstart";
     tracking.timer = 0;
   }
   
   // scoring points
   if (mousePressed && trackingTarget.mouseOverTarget() && trackingTarget.checkScreen("trackinggame")) {
     tracking.score++;
   }
}

public void flickingStartScreen() {
  textSize(50);
  fill(0, 0, 0);
  text("Flicking", 550, 100);
  back.drawButton();
  start.drawButton();
  flickingSwitch.drawSwitch();
  flickingSwitch.detectDifficulty();
}

public void flickingGame() {
   // actual flicking game
   flickingTarget.drawTarget();
   textSize(50);
   fill(0, 0, 0);
   text("Score: " + flicking.score, 550, 100);
   text("Max Score: " + flicking.maxScore, 550, 150);

   flicking.timer++;
   flickingDelay++;
   text("Time Left: " + (round((1800 - flicking.timer)/60)), 550, 200);
   
   // calculates everything once time limit is up
   if (flicking.checkTimeLimit()) {
     flicking.detectMaxScore();
   if (flickingSwitch.difficulty == "Easy" && flicking.score >= flickingSwitch.reqScore) {
     flickingSwitch.maxDifficulty = "Medium";
   } else if (flickingSwitch.difficulty == "Medium" && flicking.score >= flickingSwitch.reqScore) {
     flickingSwitch.maxDifficulty = "Hard";
   }
   // perhaps have a popup that gives you final score?
   System.out.println("Final Score: " + flicking.score);
   // reset
   screen = "flickingstart";
   flicking.timer = 0;
   }
   
   // scoring points
   if (mousePressed && flickingTarget.mouseOverTarget() && flickingTarget.checkScreen("flickinggame")) {
     flicking.score += 60;
     flickingDelay = 0;
     // removes it from the screen, there's probably a better way to do this but o well
     flickingTarget.y = 10000;
   }
   
   if (flickingSwitch.difficulty == "Easy") {
       if (flickingDelay == 40) {
         flickingTarget.x = round(random(flickingTarget.w/2, 1100 - flickingTarget.w/2));
         flickingTarget.y = 375 + round(random(-30, 30));
       }
   } else if (flickingSwitch.difficulty == "Medium") {
       if (flickingDelay == 20) {
         flickingTarget.x = round(random(flickingTarget.w/2, 1100 - flickingTarget.w/2));
         flickingTarget.y = 375 + round(random(-30, 30));
       }
   } else if (flickingSwitch.difficulty == "Hard") {
       if (flickingDelay == 10) {
         flickingTarget.x = round(random(flickingTarget.w/2, 1100 - flickingTarget.w/2));
         flickingTarget.y = 375 + round(random(-30, 30));
       }
   }
}
