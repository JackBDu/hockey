//-------------------//
//    Ball Object    //
//-------------------//

class Ball {
  
  boolean move; // whether moves or not
  boolean set; // whether set x, y value directly or not
  color fillColor; // fill color of the ball
  float ballXpos, ballYpos; // x, y position of the ball
  float diameter; // diameter of the ball
  float toX, toY; // move to what direction
  float speed; // the speed of the ball
  float setX, setY; // given position to set

  Ball() { // these values will not change throughout the program
    diameter = height/10; // set diameter
    fillColor = color(255); // set fill color as white
  }
  
  void display(boolean tempMove,float tempSpeed, float tempToX, float tempToY, boolean temSet, float temSetX, float temSetY) { // get values
    stroke(0,150,0,150); // set stroke green and half transparent
    strokeWeight(10); // set stroke weight
    move = tempMove; // assign move value
    set = temSet; // assign set value
    setX = temSetX; // assign setX value
    setY = temSetY; // assign setY value
    fill(fillColor); // fill the ball
    if (!set) { // when not forced to be certain position
      if (move){ // when hit
        toX = tempToX; // assign toX
        toY = tempToY; // assign toY
        speed = tempSpeed; // assign speed
        ballXpos += toX/sqrt((toX*toX+toY*toY))*speed; // change in x
        ballYpos += toY/sqrt((toX*toX+toY*toY))*speed; // change in y
      }

    } else { // when forced to be certain position 
      ballXpos = setX; // set X position
      ballYpos = setY; // set Y position
    }
    ellipse(ballXpos,ballYpos,diameter,diameter); // draw the ball
  }
  
}
