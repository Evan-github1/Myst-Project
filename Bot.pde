public class Bot extends Target {
  Bot(int targetX, int targetY, int targetW, int targetH, float targetDX, float targetDY) {
    super(targetX, targetY, targetW, targetH, targetDX, targetDY);
  }
    
  protected void drawTarget() {
    // head already drawn in Target class, no need to write it again
    super.drawTarget();
    stroke(2);
    stroke(0, 0, 0);
    // drawing the body, arms, and legs (conjoined in a way)
    // rect(x, y, w, h);
    rect(x, y + h/2 + 1.5 * h, 3 * w, 3 * h);
    rect(x, y + h/2 + 4 * h, 2 * w, 2 * h);
    line(x - w/2, y - h/2, x - w/2, y + h/2 + 3 * h);
    line(x - w/2, y - h/2, x - w/2, y + h/2 + 3 * h);

  }
  //protected boolean mouseOverHead() {
    
  //}
  
  //protected boolean mouseOverBodyLegs() {
    
  //}
  
}
