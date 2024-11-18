public class Bot extends Target {
  protected float hits;
  Bot(int targetX, int targetY, int targetW, int targetH, float targetDX, float targetDY) {
    super(targetX, targetY, targetW, targetH, targetDX, targetDY);
    hits = 0;
  }
    
  protected void drawTarget() {
    // head already drawn in Target class, no need to write it again
    super.drawTarget();
    stroke(2);
    stroke(0, 0, 0);
    // drawing the body, arms, and legs (uses the same hitbox)
    rect(x, y + h/2 + 1.5 * h, 3.5 * w, 3 * h);
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
  
  protected boolean detectHits() {
    if (hits >= 4) {
      return true;
    } else {
      return false;
    }
  }
  
  // no need for mouseOverBody()- it uses the same values as the parent class's mouseOverTarget()
  
}
