class slider {
  int startX;
  int y;
  int size;
  int lineLength;
  int posX;
  slider(int inX, int inY, int inLength) {
    startX = inX;
    posX = inX;
    y = inY;
    lineLength = inLength;
    size = inLength/15;
  }



  void start() {
    findX();
    ball();
  }
  void findX() {
    if (mousePressed) {
      if (mouseY > y-size/2 && mouseY < y+size/2) {

        if (mouseX < startX) {
          posX = startX;
        }
        if (mouseX > startX+lineLength) {
          posX = startX+lineLength;
        }

        if (mouseX < startX+lineLength && mouseX > startX) {  
          //return(int(mouseX));
          posX = mouseX;
        }
      }
    }
  }
  float percentage() {
    int difference = posX-startX;
    float percent = float(difference) / float(lineLength);
    return (percent);
    //String text = int(percent*100) + "%";
    //text(text, startX + difference/2, y-25);
  }

  void ball() {
    textSize(14);
    String text = int(percentage()*100) + "%";
    text(text, startX + (posX-startX)/2, y-25);

    line(startX, y, startX+lineLength, y);
    circle(posX, y, size);
  }
}

ArrayList<slider> sliders = new ArrayList<slider>();

void sliderSetup() {
  for (int i=0; i<sliders.size(); i++) {
    sliders.get(i).start();
  }
  
}

void sliderDraw() {
  for (int i=0; i<sliders.size(); i++) {
    sliders.get(i).start();
  }
}
