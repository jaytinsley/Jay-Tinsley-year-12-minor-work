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
          println(firstJoint.label+" ---> " + secondJoint.label + ": " +firstJoint.getAngle(secondJoint));
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


//class beam {
//  int x1, y1;
//  int x2, y2;
//  boolean updating = false;
//  beam() {
//    updating = true;
//    x1 = snapX(mouseX);
//    y1 = snapY(mouseY);
//    x2 = snapX(mouseX);
//    y2 = snapY(mouseY);
//  }
//  void update(int one, int two) {
//    x2 = snapX(one);
//    y2 = snapY(two);
//  }
//  void paint() {
//    strokeWeight(4);
//    line(x1, y1, x2, y2);
//    strokeWeight(1);
//  }
//}

//ArrayList <beam> beams = new ArrayList <beam>();
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
  //for (int i=0; i < beams.size(); i++) {
  //  beams.get(i).paint();
  //  if (beams.get(i).updating == true) {
  //    beams.get(i).update(mouseX, mouseY);
  //  }
  //}
  triangle(snapX(width/4), snapY((height/4)*3), snapX(width/4-width/scale), snapY(height/4*3+width/scale), snapX(width/4+width/scale), snapY(height/4*3+width/scale));
  //joints.add(new joint(width/4, (height/4)*3));
  triangle(snapX((width/4)*3), snapY((height/4)*3), snapX((width/4)*3-width/scale), snapY(height/4*3+width/scale), snapX((width/4)*3+width/scale), snapY(height/4*3+width/scale));
  //joints.add(new joint(((width/4)*3), (height/4)*3));

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
    //drawJointPointer(i);
    joints.get(i).drawPointer();
  }

  //for (int i=0; i < joints.size(); i++) {
  //  joint firstJoint = joints.get(i);
  //  for (int k=0; k < joints.get(i).connections.size(); k++) {
  //    joint secondJoint = joints.get(joints.get(i).connections.get(k));

  //  if (joints.size() >= 2) {
  //      println(firstJoint.label+": "+firstJoint.getAngle(secondJoint));
  //    }
  //  }
  //}
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

//int currentJoint = -1;
void trussesMousePressed() {  
  boolean occupied = false;
  for (int i=0; i < joints.size(); i++) {
    if (isMouseOnjoint(i)) {
      //println("on JOInt");
      occupied = true;
      joints.get(i).connections.append(currentJoint);

      joints.get(currentJoint).connections.append(i);

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
