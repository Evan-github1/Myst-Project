Buttons play, htp, trackingButton, back, start;
DifficultySwitches trackingSwitch;
RGBSwitches backgroundColorSwitchR;
String screen = "mainscreen";

public void setup() {
  size(1100, 750);
  // buttons
  play = new Buttons(550, 300, 200, 100, "PLAY");
  htp = new Buttons(550, 450, 350, 100, "HOW TO PLAY");
  trackingButton = new Buttons(550, 300, 250, 100, "TRACKING");
  back = new Buttons(1050, 700, 50, 50, "BACK");
  start = new Buttons(550, 550, 200, 100, "START");

  // switches
  trackingSwitch = new DifficultySwitches(550, 300, 300, 100);
  backgroundColorSwitchR = new RGBSwitches(550, 300, 765, 50, 74, 110, 229);
  
  textAlign(CENTER, CENTER);
}

public void draw() {
  System.out.println(backgroundColorSwitchR.returnColorValue());
  background(backgroundColorSwitchR.returnColorValue(), 110, 229);

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
  case "trackingstartscreen":
    trackingStartScreen();
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
    screen = "trackingstartscreen";
  }
  // previous screens buttons
  else if (back.mouseOverButton()) {
    if (back.checkScreen("playscreen") || back.checkScreen("howtoplayscreen")) {
      screen = "mainscreen";
    } else if (back.checkScreen("trackingstartscreen")) {
      screen = "playscreen";
    }
  }
}

public void mouseDragged() {
  if (trackingSwitch.checkScreen("trackingstartscreen")) {
    trackingSwitch.dragSlider();
  }
  backgroundColorSwitchR.dragSlider();
}

// different screens
public void mainScreen() {
  play.drawButton();
  htp.drawButton();
  backgroundColorSwitchR.drawSwitch();
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
  text("Precision Pulse is a game to train your aim in FPS games! \n\n Press PLAY on the main screen to be introduced to different courses. \n Each course's difficulty can be toggled after completing the first mode. \n\n This project is greatly inspired by popular aim trainer AimLabs. \n Made by Evan Xiang.", 550, 300);
}

public void trackingStartScreen() {
  back.drawButton();
  textSize(50);
  fill(0, 0, 0);
  text("Tracking", 550, 100);
  trackingSwitch.drawSwitch();
  trackingSwitch.detectDifficulty();
  start.drawButton();
}
