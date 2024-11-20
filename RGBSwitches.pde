class RGBSwitches extends Switches {
  public int defColor;
  protected int sliderX2, sliderX3, sliderY2, sliderY3;
  public RGBSwitches(int switchX, int switchY, int switchW, int switchH, int giveColor) {
    // inherit the constructor variables from Switches class
    super(switchX, switchY, switchW, switchH);
    sliderW = w/32;
    defColor = giveColor;
    // for every +3 in x, +1 in type of color (r, g, or b)
    sliderX = defColor * 3 + x - w/2;
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
    // gives the R/G/B number based on sliderX position
    return (sliderX - x + w/2)/(w/255);
  }
}
