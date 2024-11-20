public class Buttons {
  int x, y, w, h;
  String text;

  Buttons(int buttonX, int buttonY, int buttonW, int buttonH, String buttonText) {
    x = buttonX;
    y = buttonY;
    w = buttonW;
    h = buttonH;
    text = buttonText;
  }

  public void drawButton() {
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    // hover animation
    if (!mouseOverButton()) {
      fill(255, 255, 255);
      rect(x, y, w, h);
      fill(0, 0, 0);
      textSize(h/2.5);
      text(text, x, y);
    } else {
      fill(230, 230, 230);
      rect(x, y, w*1.2, h*1.2);
      fill(75, 181, 67);
      textSize(h*1.2/2.5);
      text(text, x, y);
    }
  }

  public boolean mouseOverButton() {
    if (mouseX <= x + w/2 && mouseX >= x - w/2 && mouseY >= y - h/2 && mouseY <= y + h/2) {
      return true;
    } else {
      return false;
    }
  }
  
  public boolean checkScreen(String buttonScreen /* enter what screen the button is */) {
    // prevents clicking nonexistent button on different screens
    if(screen == buttonScreen) {
      return true;
    } else {
      return false; 
    }
  }
}
