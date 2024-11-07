class RGBSwitches extends Switches {
  protected int r, g, b;
  protected int sliderX2, sliderX3, sliderY2, sliderY3;
  public RGBSwitches(int switchX, int switchY, int switchW, int switchH, int rd, int gd, int bd) {
    // inherit the constructor variables from Switches class
    super(switchX, switchY, switchW, switchH);
    sliderW = w/32;
    sliderX = rd * 3 + x - w/2;

    r = rd;
    g = gd;
    b = bd;
  }

  public void drawSwitch() {
    rectMode(CENTER);
    noStroke();    
    fill(0, 0, 0);
    rect(x, y, w, h/3);
    
    fill(255, 255, 255);
    rect(sliderX, sliderY, sliderW, sliderH);
  }
  
  public float returnColorValue() {
    return (sliderX - x + w/2)/3;
  }
   
}
  
