class points {
  int X, Y;
  points(int x, int y) {
    X = x;
    Y = y;
  }
}

ArrayList<points> snapPoints = new ArrayList<points>();
int scale = 25;
void gridSetup() {
  for (int i = 0; i < scale+1; i++) {
    for (int k = 0; k < scale+1; k++) {
      snapPoints.add(new points((width/scale)*i, (height/scale)*k));
    }
  }
}



void gridDraw() {
  for (int i = 0; i < scale; i++) {
    strokeWeight(0.25);
    line(0, height/scale*i, width, height/scale*i);
    line(width/scale*i, 0, width/scale*i, height);
    strokeWeight(1);
  }

  for (int i = 0; i < sq(scale+1); i++) {
    points currentPoint = snapPoints.get(i);

    circle(currentPoint.X, currentPoint.Y, 0.5);
  }
}

public int snapX(int X) {
  int storedX = 0;
  int smallestDif = width+10;
  for (int i = 0; i < snapPoints.size(); i++) {
    if (abs(snapPoints.get(i).X - X) < smallestDif) {
      smallestDif = abs(snapPoints.get(i).X - X);
      storedX = snapPoints.get(i).X;
    }
  }

  return(storedX);
}

public int snapY(int Y) {
  int storedY = 0; 
  int smallestDif = height+10;
  for (int i = 0; i < snapPoints.size(); i++) {
    if (abs(snapPoints.get(i).Y - Y) < smallestDif) {
      smallestDif = abs(snapPoints.get(i).Y - Y);
      storedY = snapPoints.get(i).Y;
    }
  }
  return(storedY);
}
