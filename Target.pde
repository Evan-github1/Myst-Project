public class Target {
  float x, y, w, h, dirChance1, dirChance2, timer, dx, dy;
  final float FX, FY, FW, FH, FDX, FDY;
  Target(int targetX, int targetY, int targetW, int targetH, float targetDX, float targetDY) {
    x = targetX;
    y = targetY;
    w = targetW;
    h = targetH;
    dx = targetDX;
    dy = targetDY;
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
  
  public void drawTarget() {
    rectMode(CENTER);
    fill(255, 255, 255);
    moveTarget();
    rect(x, y, w, h);
  }
  
  public boolean mouseOverTarget() {
    if (mouseX <= x + w/2 && mouseX >= x - w/2 && mouseY >= y - h/2 && mouseY <= y + h/2) {
      return true;
    } else {
      return false;
    }
  }
  
  public boolean checkScreen(String targetScreen /* enter what screen the target is */) {
    // prevents dragging nonexistent sliders on different screens
    if(screen == targetScreen) {
      return true;
    } else {
      return false; 
    }
  }
  
  public void moveTarget() {
     timer++;
     if (timer >= 120) {
       dirChance1 = (int) random(1, 3);
       dirChance2 = (int) random(1, 3);
       System.out.println(dirChance1);
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
