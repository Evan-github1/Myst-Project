public class Bot extends Target {
  protected float hits;
  Bot(int targetX, int targetY, int targetW, int targetH, float targetDX, float targetDY) {
    // gets alls variables from Target class
    super(targetX, targetY, targetW, targetH, targetDX, targetDY);
    hits = 0;
  }
    
  protected void drawTarget() {
    // head already drawn in Target class, no need to write it again
    super.drawTarget();
    stroke(0, 0, 0);
    // drawing the body, arms, and legs (uses the same hitbox)
    if (showBodyRed()) {
      fill(220, 20, 60);
    } else {
      fill(targetColorSwitchR.returnColorValue(), targetColorSwitchG.returnColorValue(), targetColorSwitchB.returnColorValue());
    }
    rect(x, y + h/2 + 1.5 * h, 3.5 * w, 3 * h);
    
    if (showLegsRed()) {
      fill(220, 20, 60);
    } else {
      fill(targetColorSwitchR.returnColorValue(), targetColorSwitchG.returnColorValue(), targetColorSwitchB.returnColorValue());
    }
    rect(x, y + h/2 + 4 * h, 2 * w, 2 * h);
    line(x - w, y + h/2, x - w, y + h/2 + 3 * h);
    line(x + w, y + h/2, x + w, y + h/2 + 3 * h);

  }
  
  protected boolean mouseOverBody() {
    if (mouseX <= x + (3.5 * w)/2 && mouseX >= x - (3.5 * w)/2 && mouseY >= y + h/2 && mouseY <= y + h/2 + 3 * h) {
      return true;
    } else {
      return false;
    }
  }
  
  protected boolean mouseOverLegs() {
    if (mouseX <= x + w && mouseX >= x - w && mouseY >= y + h/2 + 3 * h && mouseY <= y + h/2 + 5 * h) {
      return true;
    } else {
      return false;
    }
  }
  
  protected boolean showBodyRed() {
    if (mouseOverBody() && mousePressed) {
      return true;
    } else {
      return false;
    }
  }
  protected boolean showLegsRed() {
    if (mouseOverLegs() && mousePressed) {
      return true;
    } else {
      return false;
    }
  }
  
  protected boolean detectHits() {
    if (hits >= 240) {
      return true;
    } else {
      return false;
    }
  }
  
  // no need for mouseOverBody()- it uses the same values as the parent class's mouseOverTarget()
}
