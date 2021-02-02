class joint { 
  int X, Y;
  // list of the postion of beams in their array
  IntList connections = new IntList();

  joint() {
    X = mouseX;
    Y = mouseY;
  }
}


class beam {
  int x1, y1;
  int x2, y2;
  boolean updating = false;
  beam() {
    updating = true;
    x1 = snapX(mouseX);
    y1 = snapY(mouseY);
    x2 = snapX(mouseX);
    y2 = snapY(mouseY);
  }
  void update(int one, int two) {
    x2 = snapX(one);
    y2 = snapY(two);
  }
  void paint() {
    strokeWeight(4);
    line(x1, y1, x2, y2);
    strokeWeight(1);
  }
}

ArrayList <beam> beams = new ArrayList <beam>();
ArrayList <joint> joints = new ArrayList <joint>();


void trussesSetup() {
}

void trussesDraw() {
  for (int i=0; i < beams.size(); i++) {
    beams.get(i).paint();
    if (beams.get(i).updating == true) {
      beams.get(i).update(mouseX, mouseY);
    }
  }
}

void trussesMousePressed() {
  for (int i=0; i < joints.size(); i++) {
    
  }
  if (beams.size() != 0) {
    beams.get(beams.size()-1).updating = false;
  }
  beams.add(new beam());
}
