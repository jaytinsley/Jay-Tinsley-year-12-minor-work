void setup() {
  textAlign(CENTER);
  size(800, 800);
  
  sliderSetup();
  gridSetup();
  trussesSetup();
}

void draw() {
  background(255/2);
  sliderDraw();
  gridDraw();
  trussesDraw();
}

void mousePressed(){
  trussesMousePressed();
}
