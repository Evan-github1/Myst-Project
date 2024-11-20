public class Switches {
  protected int x, y, w, h;
  protected float sliderX, sliderY, sliderW, sliderH;
  
  protected Switches(int switchX, int switchY, int switchW, int switchH) {
    x = switchX;
    y = switchY;
    w = switchW;
    h = switchH;
    sliderX = x - w/3;
    sliderY = y;
    sliderW = w/12 * 1.1;
    sliderH = h * 1.1;
  }
  
  protected boolean mouseOverSlider() {
    if (mouseX <= sliderX + sliderW/2 && mouseX >= sliderX - sliderW/2 && mouseY >= sliderY - sliderH/2 && mouseY <= sliderY + sliderH/2) {
      return true;
    } else {
      return false;
    }
  }
 
  protected void dragSlider() {
    // allows the player to drag the slider
    if (sliderX - sliderW/2 < x - w/2) {
      sliderX = sliderW/2 + x - w/2;
    } else if (sliderX + sliderW/2 > x + w/2) {
      sliderX = x + w/2 - sliderW/2 - 1;
    }
    
    if (mouseOverSlider() && (sliderX - sliderW/2) >= (x - w/2) && (sliderX + sliderW/2) <= (x + w/2)) {
      sliderX = mouseX;
    }
  }

  protected boolean checkScreen(String switchScreen /* enter what screen the switch is */) {
    // prevents dragging nonexistent sliders on different screens
    if(screen == switchScreen) {
      return true;
    } else {
      return false; 
    }
  }
  
}
