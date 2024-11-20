public class Target {
  protected float x, y, w, h, dirChance1, dirChance2, timer, dx, dy;
  protected final float FX, FY, FW, FH, FDX, FDY;

  protected Target(int targetX, int targetY, int targetW, int targetH, float targetDX, float targetDY) { 
    // note- not all targets have to be moving, set DX and DY to 0 if it is static
    x = targetX;
    y = targetY;
    w = targetW;
    h = targetH;
    dx = targetDX;
    dy = targetDY;
    // final variables to set standard difficulty expectations
    FX = targetX;
    FY = targetY;
    FW = targetW;
    FH = targetH;
    FDX = targetDX;
    FDY = targetDY;
    
    dirChance1 = (int) random(1, 3);
    dirChance2 = (int) random(1, 3);
    timer = 0;
  }
  
  protected void drawTarget() {
    rectMode(CENTER);
    stroke(2);
    
    // flashes red if cursor is on the target and pressed
    if (showRed()) {
      fill(220, 20, 60);
    } else {
      fill(targetColorSwitchR.returnColorValue(), targetColorSwitchG.returnColorValue(), targetColorSwitchB.returnColorValue());
    }
    moveTarget();
    rect(x, y, w, h);
  }
  
  protected boolean mouseOverTarget() {
    if (mouseX <= x + w/2 && mouseX >= x - w/2 && mouseY >= y - h/2 && mouseY <= y + h/2) {
      return true;
    } else {
      return false;
    }
  }
  
  protected boolean showRed() {
    if (mouseOverTarget() && mousePressed) {
      return true;
    } else {
      return false;
    }
  }
  
  protected boolean checkScreen(String targetScreen /* enter what screen the target is */) {
    // prevents dragging nonexistent sliders on different screens
    if(screen == targetScreen) {
      return true;
    } else {
      return false; 
    }
  }
  
  protected void moveTarget() {
     // randomizes target movement
     timer++;
     if (timer >= 60) {
       dirChance1 = (int) random(1, 3);
       dirChance2 = (int) random(1, 3);
       timer = 0;
     }
     
       if (x + w/2 >= 1100 || x - w/2 <= 0) {
         dx *= -1;
       }
       if (y - h/2 <= 0 || y + h/2 >= 750) {
         dy *= -1;
       }
       
       if (dirChance1 == 1) {
         x += dx;
       } else if (dirChance1 == 2) {
         x -= dx;
       }
       
       if (dirChance2 == 1) {
         y -= dy;
       } else if (dirChance2 == 2) {
         y += dy;
       }
     
  }
}
