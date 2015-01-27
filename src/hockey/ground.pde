//-------------------//
//   Ground Object   //
//-------------------//


class Ground {
  
  color lineColor, fillColor; // define fill color and line color

  Ground() { // these values will not change throughout the program
    lineColor = color(0,150,0,150); // set line color to green and half transparent
    fillColor = color(0); // set fill color to black
  }
  
  void display() {
    strokeWeight(10); // set stroke weight
    stroke(lineColor); // set line color
    fill(fillColor); // set fill color
    ellipse(width/2,height/2,height*2/5,height*2/5); // draw a circle in center
    line(0,0,width,0); // draw line at the top
    line(0,height,width,height); // draw line at the bottom
    line(width/2,0,width/2,height); // draw line in the middle
    line(0,0,0,height); // draw line on the left
    line(width,0,width,height); // draw line on the right
    ellipse(0,height/2,height*2/5,height*2/5); // draw circle on the left
    ellipse(width,height/2,height*2/5,height*2/5); // draw circle on the right
  }
  
}
