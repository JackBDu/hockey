//-------------------//
//   Player Object   //
//-------------------//

class Player {
  
  color outter, inner; // define colors
  float xpos, ypos; // define position
  float outterD, innerD; // define diameter

  Player() { // these values will not change throughout the program
    outter = color(255); // outter color is white
    inner = color(0); // inner color is black
    outterD = height/5; // set outter diameter
    innerD = height/10; //  set inner diameter
  }
  
  void display(float tempXpos,float tempYpos) { // get position values
    xpos = tempXpos; // assign tempXpos to xpos
    ypos = tempYpos; // assign tempYpos to ypos
    stroke(0,150,0,150); // set stroke color to green and half transparent
    strokeWeight(10); // set stroke weight
    fill(outter); // fill outter color
    ellipse(xpos,ypos,outterD,outterD); // draw outter circle
    fill(inner); // fill inner color
    ellipse(xpos,ypos,innerD,innerD); // draw inner circle
  }

}
