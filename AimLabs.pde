// variables and objects
Buttons play, htp, trackingButton, back, start, settings, restoreDefault, flickingButton, ballColorButton, gridButton;
DifficultySwitches trackingSwitch, flickingSwitch, gridSwitch;
RGBSwitches backgroundColorSwitchR, backgroundColorSwitchG, backgroundColorSwitchB, targetColorSwitchR, targetColorSwitchG, targetColorSwitchB;
Game tracking, flicking, grid;
Target trackingTarget, demoTarget, gridTarget1, gridTarget2, gridTarget3;
Bot flickingBot, demoBot;
String screen = "mainscreen";
int flickingDelay = 0;
int grid1x, grid1y, grid2x, grid2y, grid3x, grid3y;

public void setup() {
  size(1100, 750);
  // button objects
  play = new Buttons(550, 250, 200, 100, "PLAY");
  htp = new Buttons(550, 400, 350, 100, "HOW TO PLAY");
  settings = new Buttons(550, 550, 250, 100, "SETTINGS");
  
  trackingButton = new Buttons(550, 250, 250, 100, "TRACKING");
  flickingButton = new Buttons(550, 400, 250, 100, "FLICKING");
  gridButton = new Buttons(550, 550, 250, 100, "3X3 GRID");

  back = new Buttons(1050, 700, 50, 50, "BACK");
  start = new Buttons(550, 550, 200, 100, "START");

  restoreDefault = new Buttons(550, 650, 350, 100, "RESTORE DEFAULT");
  ballColorButton = new Buttons(75, 700, 100, 50, "CUSTOMIZE"); 

  // switch objects
  // difficulty switches
  trackingSwitch = new DifficultySwitches(550, 300, 300, 100, 400);
  flickingSwitch = new DifficultySwitches(550, 300, 300, 100, 600);
  gridSwitch = new DifficultySwitches(550, 300, 300, 100, 1000);
  
  // RGB switches
  backgroundColorSwitchR = new RGBSwitches(550, 275, 765, 50, 74);
  backgroundColorSwitchG = new RGBSwitches(550, 375, 765, 50, 110);
  backgroundColorSwitchB = new RGBSwitches(550, 475, 765, 50, 229);
  
  targetColorSwitchR = new RGBSwitches(550, 325, 765, 50, 253);
  targetColorSwitchG = new RGBSwitches(550, 425, 765, 50, 253);
  targetColorSwitchB = new RGBSwitches(550, 525, 765, 50, 253);

  // game data objects
  tracking = new Game(20);
  flicking = new Game(30);
  grid = new Game(20);
  
  // target objects
  trackingTarget = new Target(550, 375, 50, 50, 3, 3);
  flickingBot = new Bot(550, 375, 10, 10, 0, 0);
  demoTarget = new Target(475, 200, 50, 50, 0, 0);
  demoBot = new Bot(625, 155, 15, 15, 0, 0);
  
  gridTarget1 = new Target(550 + grid1x, 375 + grid1y, 40, 40, 0, 0);
  gridTarget2 = new Target(550 + grid2x, 375 + grid2y, 40, 40, 0, 0);
  gridTarget3 = new Target(550 + grid3x, 375 + grid3y, 40, 40, 0, 0);

  textAlign(CENTER, CENTER);
}

public void draw() {
  // changes background color based on RGB change in settings
  background(backgroundColorSwitchR.returnColorValue(), backgroundColorSwitchG.returnColorValue(), backgroundColorSwitchB.returnColorValue());
  
  // changes screens through methods
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
    trackingGame();
    break;
  case "flickingstart":
    flickingStartScreen();
    break;
  case "flickinggame":
    flickingGame();
    break;
  case "targetchangescreen":
    targetColorChangeScreen();
    break;
  case "gridstart":
    gridStartScreen();
    break;
  case "gridgame":
    gridGame();
    break;
  }
}

public void mouseReleased() {
  // button presses
  // switches screens and disables buttons not relative to screen
  // (this means every if statement should at least have a mouseOverButton() and checkScreen(String) method)
  if (play.mouseOverButton() && play.checkScreen("mainscreen")) {
      // different games screen
      screen = "playscreen";
  } else if (htp.mouseOverButton() && htp.checkScreen("mainscreen")) {
      // how to play screen
      screen = "howtoplayscreen";
  } else if (trackingButton.mouseOverButton() && trackingButton.checkScreen("playscreen")) {
      // stats and difficulty for tracking
      screen = "trackingstart";
  } else if (flickingButton.mouseOverButton() && trackingButton.checkScreen("playscreen")) {
      // stats and difficulty for flicking
      screen = "flickingstart";
  } else if (gridButton.mouseOverButton() && gridButton.checkScreen("playscreen")) {
      // stats and difficulty for 3x3 grid
      screen = "gridstart";
  } else if (settings.mouseOverButton() && settings.checkScreen("mainscreen")) {
      // settings (background color change) screen
      screen = "settingsscreen";
  } else if (ballColorButton.mouseOverButton() && ballColorButton.checkScreen("playscreen")) {
      // target color change screen
      screen = "targetchangescreen";
  } else if (restoreDefault.mouseOverButton()) {
      // restore default colors
      if (restoreDefault.checkScreen("settingsscreen")) {
        // background
        backgroundColorSwitchR.sliderX = 74 * 3 + backgroundColorSwitchR.x - backgroundColorSwitchR.w/2;
        backgroundColorSwitchG.sliderX = 110 * 3 + backgroundColorSwitchG.x - backgroundColorSwitchG.w/2;
        backgroundColorSwitchB.sliderX = 229 * 3 + backgroundColorSwitchB.x - backgroundColorSwitchB.w/2;
      } else if (restoreDefault.checkScreen("targetchangescreen")) {
        // target
        targetColorSwitchR.sliderX = 253 * 3 + targetColorSwitchR.x - targetColorSwitchR.w/2;
        targetColorSwitchG.sliderX = 253 * 3 + targetColorSwitchG.x - targetColorSwitchG.w/2;
        targetColorSwitchB.sliderX = 253 * 3 + targetColorSwitchB.x - targetColorSwitchB.w/2;
      }
  } else if (start.checkScreen("trackingstart") && start.mouseOverButton()) {
      // tracking game
      // resets variables
      tracking.score = 0;
      tracking.timer = 0;
      trackingTarget.x = trackingTarget.FX;
      trackingTarget.y = trackingTarget.FY;
      
      // detects adapts to difficulty
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
      // flicking game
      // resets variables
      flicking.score = 0;
      flicking.timer = 0;
      flickingBot.x = flickingBot.FX;
      flickingBot.y = flickingBot.FY;
      
      screen = "flickinggame";
  } else if (start.checkScreen("gridstart") && start.mouseOverButton()) {
      // grid game
      // resets variables / randomizes positions
      grid.score = 0;
      grid.timer = 0;
      grid1x = randPos(round(random(0, 2)));
      grid1y = randPos(round(random(0, 2)));
      grid2x = randPos(round(random(0, 2)));
      grid2y = randPos(round(random(0, 2)));
      grid3x = randPos(round(random(0, 2)));
      grid3y = randPos(round(random(0, 2)));
      occGrid(1);
      occGrid(2);
      occGrid(3);
      gridTarget1.x = 550 + grid1x;
      gridTarget1.y = 375 + grid1y;
      gridTarget2.x = 550 + grid2x;
      gridTarget2.y = 375 + grid2y;
      gridTarget3.x = 550 + grid3x;
      gridTarget3.y = 375 + grid3y;
      
      // detects adapts to difficulty
      if (gridSwitch.difficulty == "Easy") {
         gridTarget1.w = gridTarget1.FW;
         gridTarget1.h = gridTarget1.FH;
         gridTarget2.w = gridTarget2.FW;
         gridTarget2.h = gridTarget2.FH;
         gridTarget3.w = gridTarget3.FW;
         gridTarget3.h = gridTarget3.FH;
       } else if (gridSwitch.difficulty == "Medium") {
         gridTarget1.w = gridTarget1.FW/1.5;
         gridTarget1.h = gridTarget1.FH/1.5;
         gridTarget2.w = gridTarget2.FW/1.5;
         gridTarget2.h = gridTarget2.FH/1.5;
         gridTarget3.w = gridTarget3.FW/1.5;
         gridTarget3.h = gridTarget3.FH/1.5;
       } else if (gridSwitch.difficulty == "Hard") {
         gridTarget1.w = gridTarget1.FW/2;
         gridTarget1.h = gridTarget1.FH/2;
         gridTarget2.w = gridTarget2.FW/2;
         gridTarget2.h = gridTarget2.FH/2;
         gridTarget3.w = gridTarget3.FW/2;
         gridTarget3.h = gridTarget3.FH/2;
       }
       
      screen = "gridgame";
  } else if (back.mouseOverButton()) {
    // different back buttons
    if (back.checkScreen("playscreen") || back.checkScreen("howtoplayscreen") || back.checkScreen("settingsscreen")) {
      screen = "mainscreen";
    } else if (back.checkScreen("trackingstart") || back.checkScreen("flickingstart") || back.checkScreen("targetchangescreen") || back.checkScreen("gridstart")) {
      screen = "playscreen";
    } 
  }
}

public void mouseDragged() {
  // what makes the sliders work
  // difficulty sliders
  if (trackingSwitch.checkScreen("trackingstart")) {
    // tracking
    trackingSwitch.dragSlider();
  } else if (flickingSwitch.checkScreen("flickingstart")) {
    // flicking
    flickingSwitch.dragSlider();
  } else if (gridSwitch.checkScreen("gridstart")) {
    // grid
    gridSwitch.dragSlider();
  } 
  // RGB customization
  else if (backgroundColorSwitchR.checkScreen("settingsscreen") || backgroundColorSwitchG.checkScreen("settingsscreen") || backgroundColorSwitchB.checkScreen("settingsscreen")) {
    // background
    backgroundColorSwitchR.dragSlider();
    backgroundColorSwitchG.dragSlider();
    backgroundColorSwitchB.dragSlider();
  } else if (targetColorSwitchR.checkScreen("targetchangescreen") || targetColorSwitchG.checkScreen("targetchangescreen") || targetColorSwitchB.checkScreen("targetchangescreen")) {
    // target
    targetColorSwitchR.dragSlider();
    targetColorSwitchG.dragSlider();
    targetColorSwitchB.dragSlider();
  }
}

// different screens
// "default" screens
public void mainScreen() {
  // home screen, aka the first screen you see
  play.drawButton();
  htp.drawButton();
  settings.drawButton();
  textSize(50);
  fill(0, 0, 0);
  text("Precision Pulse", 550, 100);
}

public void playScreen() {
  // all games screen
  trackingButton.drawButton();
  flickingButton.drawButton();
  gridButton.drawButton();
  ballColorButton.drawButton();
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

// game start screens

public void trackingStartScreen() {
  // adjust difficulty and press start for tracking
  tracking.showScore();
  back.drawButton();
  textSize(50);
  fill(0, 0, 0);
  text("Tracking", 550, 100);
  trackingSwitch.drawSwitch();
  trackingSwitch.detectDifficulty();
  start.drawButton();
}

public void flickingStartScreen() {
  // adjust difficulty and press start for flicking
  flicking.showScore();
  textSize(50);
  fill(0, 0, 0);
  text("Flicking", 550, 100);
  back.drawButton();
  start.drawButton();
  flickingSwitch.drawSwitch();
  flickingSwitch.detectDifficulty();
}

public void gridStartScreen() {
  // adjust difficulty and press start for 3x3 grid
  grid.showScore();
  textSize(50);
  fill(0, 0, 0);
  text("3x3 Grid", 550, 100);
  back.drawButton();
  start.drawButton();
  gridSwitch.drawSwitch();
  gridSwitch.detectDifficulty();
}

// games

public void trackingGame() {
   // actual tracking game
   textSize(50);
   fill(0, 0, 0);
   text("Score: " + tracking.score, 550, 100);
   text("High Score: " + tracking.maxScore, 550, 150);

   trackingTarget.drawTarget();
   tracking.timer++;
   fill(255, 255, 255);
   text("Time Left: " + (round((1200 - tracking.timer)/60)), 550, 200);
   
   // calculates everything once time limit is up
   if (tracking.checkTimeLimit()) {
     tracking.detectMaxScore();
     if (trackingSwitch.difficulty == "Easy" && tracking.score >= trackingSwitch.reqScore) {
       trackingSwitch.maxDifficulty = "Medium";
     } else if (trackingSwitch.difficulty == "Medium" && tracking.score >= trackingSwitch.reqScore) {
       trackingSwitch.maxDifficulty = "Hard";
     }

     // reset
     screen = "trackingstart";
     tracking.timer = 0;
   }
   
   // scoring points
   if (mousePressed && trackingTarget.mouseOverTarget() && trackingTarget.checkScreen("trackinggame")) {
     tracking.score++;
   }
}

public void flickingGame() {
   // actual flicking game
   flickingBot.drawTarget();
   textSize(50);
   fill(0, 0, 0);
   text("Score: " + flicking.score, 550, 100);
   text("High Score: " + flicking.maxScore, 550, 150);

   flicking.timer++;
   flickingDelay++;
   
   fill(255, 255, 255);
   text("Time Left: " + (round((1800 - flicking.timer)/60)), 550, 200);
   
   // calculates everything once time limit is up
   if (flicking.checkTimeLimit()) {
     flicking.detectMaxScore();
   if (flickingSwitch.difficulty == "Easy" && flicking.score >= flickingSwitch.reqScore) {
     flickingSwitch.maxDifficulty = "Medium";
   } else if (flickingSwitch.difficulty == "Medium" && flicking.score >= flickingSwitch.reqScore) {
     flickingSwitch.maxDifficulty = "Hard";
   }
   // reset
   screen = "flickingstart";
   flicking.timer = 0;
   }
   
   // scoring points
   if (mousePressed && flickingBot.checkScreen("flickinggame")) {
     // different parts of bot's body deals different amounts of "damage"
     if (flickingBot.mouseOverTarget()) { // aka head
       flickingBot.hits += 240;
     } else if (flickingBot.mouseOverBody()) {
       flickingBot.hits += 10;
     } else if (flickingBot.mouseOverLegs()) {
       flickingBot.hits += 8;
     }
   }
   
   if (flickingBot.detectHits()) {
     flicking.score += 60;
     flickingDelay = 0;
     // removes it from visible screen
     flickingBot.y = 10000;
     flickingBot.hits = 0;
   }
   
   // moving it at different rates based on difficulty
   switch (flickingSwitch.difficulty) {
     case "Easy":
       if (flickingDelay == 90) {
         flickingBot.x = round(random(flickingBot.w/2, 1100 - flickingBot.w/2));
         flickingBot.y = 375 + round(random(-30, 30));
         flickingDelay = 0;
       }
       break;
     case "Medium":
       if (flickingDelay == 75) {
         flickingBot.x = round(random(flickingBot.w/2, 1100 - flickingBot.w/2));
         flickingBot.y = 375 + round(random(-30, 30));
         flickingDelay = 0;
       }
       break;
     case "Hard":
       if (flickingDelay == 60) {
         flickingBot.x = round(random(flickingBot.w/2, 1100 - flickingBot.w/2));
         flickingBot.y = 375 + round(random(-30, 30));
         flickingDelay = 0;
       }
       break;
   }
}

public void gridGame() {
   // actual 3x3 grid game
   textSize(50);
   fill(0, 0, 0);
   text("Score: " + grid.score, 550, 100);
   text("High Score: " + grid.maxScore, 550, 150);
  
   gridTarget1.drawTarget();
   gridTarget2.drawTarget();
   gridTarget3.drawTarget();

   grid.timer++;
   fill(255, 255, 255);
   text("Time Left: " + (round((1200 - grid.timer)/60)), 550, 200);
   
   // calculates everything once time limit is up
   if (grid.checkTimeLimit()) {
     grid.detectMaxScore();
   if (gridSwitch.difficulty == "Easy" && grid.score >= gridSwitch.reqScore) {
     gridSwitch.maxDifficulty = "Medium";
   } else if (gridSwitch.difficulty == "Medium" && grid.score >= gridSwitch.reqScore) {
     gridSwitch.maxDifficulty = "Hard";
   }
   // reset
   screen = "gridstart";
   grid.timer = 0;
   }
   
   // scoring points
   if (mousePressed) {
     if (gridTarget1.mouseOverTarget() && gridTarget1.checkScreen("gridgame")) {
       grid1x = randPos(round(random(0, 2)));
       grid1y = randPos(round(random(0, 2)));
       occGrid(1);
       grid.score += 25;
     } else if (gridTarget2.mouseOverTarget() && gridTarget2.checkScreen("gridgame")) {
       grid2x = randPos(round(random(0, 2)));
       grid2y = randPos(round(random(0, 2)));
       occGrid(2);
       grid.score += 25;
     } else if (gridTarget3.mouseOverTarget() && gridTarget3.checkScreen("gridgame")) {
       grid3x = randPos(round(random(0, 2)));
       grid3y = randPos(round(random(0, 2)));
       occGrid(3);
       grid.score += 25;
     }
   }
   
    // changes position based on randomizer (above)
    gridTarget1.x = 550 + grid1x;
    gridTarget1.y = 375 + grid1y;
    gridTarget2.x = 550 + grid2x;
    gridTarget2.y = 375 + grid2y;
    gridTarget3.x = 550 + grid3x;
    gridTarget3.y = 375 + grid3y;
}

// RGB color changes

public void targetColorChangeScreen() {
  back.drawButton();
  // change target color
  targetColorSwitchR.drawSwitch();
  targetColorSwitchG.drawSwitch();
  targetColorSwitchB.drawSwitch();
  restoreDefault.drawButton();
  // example targets for player to visualize
  demoTarget.drawTarget();
  demoBot.drawTarget();
  textSize(50);
  fill(0, 0, 0);
  text("Customize Your Targets!", 550, 100);
  text("R:", targetColorSwitchR.x - targetColorSwitchR.w/1.8, targetColorSwitchR.y);
  text("G:", targetColorSwitchG.x - targetColorSwitchG.w/1.8, targetColorSwitchG.y);
  text("B:", targetColorSwitchB.x - targetColorSwitchB.w/1.8, targetColorSwitchB.y);
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

// other method(s)

public int randPos(int prob) {
  // helps randomizes position for grid targets
  switch (prob) {
    case 0:
      return 100;
    case 1:
      return 0;
    case 2:
      return -100;
    default:
      return 0;
  }
}

public void occGrid(int gridNum) {
  // randomizes position for grid targets to ensure no overlap
  switch (gridNum) {
  case 1:
    while ((grid1x == grid2x && grid1y == grid2y) || (grid1x == grid3x && grid1y == grid3y) ) {
      grid1x = randPos(round(random(0, 2)));
      grid1y = randPos(round(random(0, 2)));
    }
    break;
  case 2:
    while ((grid2x == grid1x && grid2y == grid1y) || (grid2x == grid3x && grid2y == grid3y) ) {
      grid2x = randPos(round(random(0, 2)));
      grid2y = randPos(round(random(0, 2)));
    }
    break;
  case 3:
    while ((grid3x == grid2x && grid3y == grid2y) || (grid3x == grid1x && grid3y == grid1y)) {
      grid3x = randPos(round(random(0, 2)));
      grid3y = randPos(round(random(0, 2)));
    }
    break;
}
}
