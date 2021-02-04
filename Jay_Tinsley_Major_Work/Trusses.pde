class joint { 
  int X, Y;
  String label;
  // list of the postion of whatever in their array
  IntList connections = new IntList();

  joint(int inX, int inY, String label) {
    X = snapX(inX);
    Y = snapY(inY);
    this.label = label;
  }

  void drawPointer() {
    fill(255);
    circle(X, Y, 10);
    textSize(25);
    text(label, X-15, Y-15);
    fill(0);

    for (int i=0; i < joints.size(); i++) {
      joint firstJoint = joints.get(i);
      for (int k=0; k < joints.get(i).connections.size(); k++) {
        joint secondJoint = joints.get(joints.get(i).connections.get(k));

        if (joints.size() >= 2) {
          //println(firstJoint.label+" ---> " + secondJoint.label + ": " +firstJoint.getAngle(secondJoint));
          float angle = firstJoint.getAngle(secondJoint);
          textSize(12.5);
          fill(255);
          text("--> "+secondJoint.label +": "+angle, firstJoint.X + (width/scale), firstJoint.Y - (height/scale)*(k+1));
        }
      }
    }
  }

  float getAngle(joint otherJoint) {
    float Xdiff = otherJoint.X - X;
    float Ydiff = (otherJoint.Y - Y)*-1;
    //return(atan(Ydiff, X)*180/PI);
    //return(atan((Ydiff/Xdiff)*180/PI));
    return(atan((Ydiff/Xdiff))*180/PI);
  }
}

ArrayList <joint> joints = new ArrayList <joint>();


void trussesSetup() {
  joints.add(new joint(((width/4)*3), (height/4)*3, Integer.toString(0)));
  joints.add(new joint(width/4, (height/4)*3, Integer.toString(1)));

  joints.get(joints.size()-2).connections.append(joints.size()-1);
  joints.get(joints.size()-1).connections.append(joints.size()-2);


  currentJoint = joints.size()-1;
}
int currentJoint = -1;
void trussesDraw() {

  triangle(snapX(width/4), snapY((height/4)*3), snapX(width/4-width/scale), snapY(height/4*3+width/scale), snapX(width/4+width/scale), snapY(height/4*3+width/scale));
  triangle(snapX((width/4)*3), snapY((height/4)*3), snapX((width/4)*3-width/scale), snapY(height/4*3+width/scale), snapX((width/4)*3+width/scale), snapY(height/4*3+width/scale));

  for (int i=0; i < joints.size(); i++) {
    joint firstJoint = joints.get(i);
    fill(255);
    circle(firstJoint.X, firstJoint.Y, 10);
    fill(0);
    for (int k=0; k < joints.get(i).connections.size(); k++) {
      joint secondJoint = joints.get(joints.get(i).connections.get(k));
      strokeWeight(4);
      line(firstJoint.X, firstJoint.Y, secondJoint.X, secondJoint.Y);
      strokeWeight(1);
    }
  }
  for (int i=0; i < joints.size(); i++) {
    joints.get(i).drawPointer();
  }

  showCurrentJoint();
}

void showCurrentJoint() {
  if (currentJoint != -1) {
    fill(98, 231, 27);
    circle(joints.get(currentJoint).X, joints.get(currentJoint).Y, 10);
    fill(255);
  }
}

boolean isMouseOnjoint(int jointArrayIndex) {
  return(snapX(mouseX) == joints.get(jointArrayIndex).X && snapX(mouseY) == joints.get(jointArrayIndex).Y);
}
boolean isConnectionAlreadyMade(joint firstJoint, joint secondJoint) {
  for (int k=0; k < secondJoint.connections.size(); k++) {
    if (int(firstJoint.label) == secondJoint.connections.get(k)) {
      return(true);
    }
  }
  return(false);
}
void trussesMousePressed() {  
  boolean occupied = false;
  for (int i=0; i < joints.size(); i++) {
    if (isMouseOnjoint(i)) {
      occupied = true;
      if (isConnectionAlreadyMade(joints.get(i), joints.get(currentJoint)) == false) {
        joints.get(i).connections.append(currentJoint);

        joints.get(currentJoint).connections.append(i);
      }
      currentJoint = i;
    }
  }
  if (occupied == false) {
    joints.add(new joint(mouseX, mouseY, Integer.toString(joints.size())));
    if (joints.size() >= 2) {
      int newJoint = joints.size()-1;
      joints.get(newJoint).connections.append(currentJoint);
      joints.get(currentJoint).connections.append(newJoint);
    }
    currentJoint = joints.size()-1;
  }

  for (int i=0; i < joints.size(); i++) {
    println(i +": "+joints.get(i).connections);
  }
  println("current Joint: " + currentJoint);
  println();
}
