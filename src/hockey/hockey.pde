//-------------------//
//     Main Body     //
//-------------------//

Player player;
Player computer;
Ball ball;
Ground ground;
boolean move = false, setBall;
boolean mouseDown = false;
boolean keyDown = false;
boolean BPtouched;
boolean BCtouched;
float playerX, playerY;
float pPlayerX, pPlayerY;
float computerX, computerY;
float pComputerX, pComputerY;
float ballX, ballY;
float pBallX, pBallY;
float playerUpLimit, playerDownLimit, playerLeftLimit, playerRightLimit;
float computerUpLimit, computerDownLimit,computerLeftLimit, computerRightLimit;
float ballLeftLimit, ballRightLimit, ballUpLimit, ballDownLimit;
float BPtouch, BCtouch; // ball and player touch
float BPdistance, BCdistance; // distance between ball and player
float directionX = 0, directionY = 0;
float speed = 0;
float maxBallSpeed = 15;
float computerRealSpeed;
int computerScore = 0, playerScore = 0;
int maxComputerSpeed = 5, computerSpeed = 0; // max speed
int playerCount = 100, computerCount = 100;
int countToStart = 120;

void setup() { // these values will not change throughout the program
  size(1024, 640);
  background(0);
  smooth();
  playerUpLimit = height/10;
  computerUpLimit = playerUpLimit;
  ballUpLimit = height/20;
  playerDownLimit = height*9/10;
  computerDownLimit = playerDownLimit;
  ballDownLimit = height - height/20;
  playerLeftLimit = width/2;
  computerLeftLimit = height/10;
  computerRightLimit = width/2;
  ballLeftLimit = height/20;
  playerRightLimit = width-height/10;
  ballRightLimit = width - height/20;
  BPtouch = height/10+height/20;
  BCtouch = BPtouch;
  BPtouched = false;
  BCtouched = false;
  ball = new Ball();
  player = new Player();
  computer = new Player();
  ground = new Ground();
} // curly bracket for setup()

void draw() {

  ///////////////////////
  //       Ground      //
  ///////////////////////
  background(0); // to erase
  fill(color(0));
  ground.display();

  if(countToStart>0) {
    countToStart--;
    computerX = width*1/4;
    computerY = height/2;
    playerX = width*3/4;
    playerY = height/2;
    setBall = true;
    move = false;
    ballX = width/2;
    ballY = height/2;
    speed = 0;
    computer.display(computerX,computerY);
    player.display(playerX,playerY);
    ball.display(move,speed,directionX,directionY,setBall,ballX,ballY);
    fill(0,0,0,100);
    rect(0,0,width,height);
    fill(0,150,0,200);
    textSize(100);
    text(floor(countToStart/40)+1, width/2-30, height/2);
  } else {
    setBall = false;
    ballX = ball.ballXpos;
    ballY = ball.ballYpos;
    if (computerScore<7 && playerScore<7) {
      ///////////////////////
      // Player's Movement //
      ///////////////////////
      
      if (mouseDown) {
        // for playerX value
        if (mouseX>=playerLeftLimit && mouseX<=playerRightLimit){  // player should not move to the left side
          playerX = mouseX;
        } else if (mouseX>playerRightLimit) { // avoid moving out of the window
          playerX = playerRightLimit;
        } else {
          playerX = width/2; // avoid the case that mouse move out and appear on the left
        }
      
        // for playerY value
        if (mouseY>=playerUpLimit && mouseY<=playerDownLimit){ // limit the up and down 
          playerY = mouseY;
        } else if (mouseY<playerUpLimit) {  // avoid moving out upside
          playerY = playerUpLimit;
        } else if (mouseY>playerDownLimit) {  // avoid moving out downside
          playerY = playerDownLimit;
        }
      }
      
      /////////////////////////
      // computer's Movement //
      /////////////////////////  
      
      // try to get the ball on Y axis
      if (ballY > computerY) {
        if (ballY-computerY>computerSpeed && computerSpeed<maxComputerSpeed) {
          computerSpeed++; // adjust speed
        } else if (computerSpeed>0) {
          computerSpeed--; // adjust speed
        }
        computerY += computerSpeed;
        
      } else if (ballY < computerY) {
        if (computerY-ballY>computerSpeed &&  computerSpeed<maxComputerSpeed) {
          computerSpeed++; // adjust speed
        } else if (computerSpeed>0) {
          computerSpeed--; // adjust speed
        }
        computerY -= computerSpeed;
      }
  
      // avoid own goal
      if ((ballX-height/20)<=(computerX+height/10)) {  // ball is on the left of the computer
        if (ballY<computerY) { // center of ball is above center of computer 
          if ((ballY+height/20+10)<(computerY-height/10)) { // ball is above computer
            computerX -= maxComputerSpeed; // chase the ball
          } else {
            computerY += maxComputerSpeed; // avoid hitting the ball
            computerX -= maxComputerSpeed; // chase the ball
          }
          
        } else { // center of ball is below center of computer
          if ((ballY-height/20)>(computerY+height/10+10)) { // ball is below computer
            computerX -= maxComputerSpeed; // chase the ball
          } else {
            computerY -= maxComputerSpeed; // avoid hitting the ball
            computerX -= maxComputerSpeed; // chase the ball
          }
        }
      } else {
      
        if (ballX<=width/2) {
          computerX += maxComputerSpeed;
        } else if (computerX>width*1/4) {
          computerX -= maxComputerSpeed;
        }
      
      }
      
      if (computerX<computerLeftLimit) { // avoid moving out of the window
        computerX = computerLeftLimit;
      } else if (computerX>computerRightLimit) {
        computerX = width/2; // avoid the case that computer move out and appear on the left
      }
      
       // for computerY value
      if (computerY<computerUpLimit) {  // avoid moving out upside
        computerY = computerUpLimit;
      } else if (computerY>playerDownLimit) {  // avoid moving out downside
        computerY = computerDownLimit;
      }
      
      
      
    //  }
    }
  
  
    ///////////////////////////////////////
    // whether Computer and Ball touches //
    ///////////////////////////////////////
    
    BCdistance = sqrt((computerX-ballX)*(computerX-ballX)+(computerY-ballY)*(computerY-ballY));
    if (BCdistance<=BCtouch) {
      BCtouched = true; 
    } else {
      BCtouched = false;
    }
    if (BCtouched) {
      computerCount--; // start to count when ball and computer touches
      move = true;
      directionX = ballX-computerX;
      directionY = ballY-computerY;
      computerRealSpeed = sqrt((pComputerX-computerX)*(pComputerX-computerX)+(pComputerY-computerY)*(pComputerY-computerY));
      if (computerRealSpeed <= 2) {
        speed -= 5;
      } else if (computerRealSpeed <= 4) {
        speed -= 1;
      } else {
        speed += 5;
      }
    
      if (speed<(BCtouch-BCdistance)){
        speed = BCtouch-BCdistance;
      } else {
        speed = maxBallSpeed;
      }
    } else if (speed>maxBallSpeed) {
      speed = maxBallSpeed;
      computerCount = 100;
    }
    
    if (computerCount<0) { // avoid ball in the corner
      if (computerY<(height/10+height/10)) {
        computerY = height/10+height/10+1;
        computerX -= maxComputerSpeed;
      } else if (computerY>(height-height/10-height/10)) {
        computerY = height-height/10-height/10-1;
        computerX -= maxComputerSpeed;
      }
      if (computerX < height/10 - height/10) {
        computerX = height/10 - height/10 + 1;
        if (computerY>height/2) {
          computerY -= maxComputerSpeed;
        } else {
          computerY += maxComputerSpeed;
        }
        
      }
    }
    
    
    /////////////////////////////////////
    // whether Player and Ball touches //
    /////////////////////////////////////
    BPdistance = sqrt((playerX-ballX)*(playerX-ballX)+(playerY-ballY)*(playerY-ballY));
    if(BPdistance<=BPtouch) {
      BPtouched = true;
    } else {
      BPtouched = false;
    }
    if (BPtouched) {
      playerCount--; // start to count when ball and player touches
      move = true;
      directionX = ballX-playerX;
      directionY = ballY-playerY;
      speed = sqrt((pPlayerX-playerX)*(pPlayerX-playerX)+(pPlayerY-playerY)*(pPlayerY-playerY))+speed-1;
      if (speed<(BPtouch-BPdistance)){
        speed = BPtouch-BPdistance;
      }
    } else if (speed>maxBallSpeed) {
      speed = maxBallSpeed;
      playerCount = 100;
    } else {
      playerCount = 100;
    }
    
    if (playerCount<0) { // avoid ball in the corner
      if (playerY<(height/10+height/10)) {
        playerY = height/10+height/10+1;
      } else if (playerY>(height-height/10-height/10)) {
        playerY = height-height/10-height/10-1;
      }
      if (playerX > width - height/10 - height/10) {
        playerX = width - height/10 - height/10 + 1;
      }
    }

    ballX = ball.ballXpos;
    ballY = ball.ballYpos;
    
    /////////////////////
    //   Ball's field  //
    /////////////////////
    if (ballY<(height*3/10+height/20) || ballY>(height*3/10+height*2/5-height/20)){
      if (ballX < ballLeftLimit || ballX > ballRightLimit){ 
        setBall = true;
        if (ballX < ballLeftLimit) {
          ballX = ballLeftLimit;
        } else {
          ballX = ballRightLimit;
        }
      float speedX = abs(pBallX-ballX);
      directionX = -directionX;
      }
    }
    
    if (ballY < ballUpLimit || ballY > ballDownLimit){
      setBall = true;
      if (ballY < ballUpLimit) {
        ballY = ballUpLimit;
      } else {
        ballY = ballDownLimit;
      }
      float speedY = abs(pBallY-ballY);
      directionY = -directionY;
    }
    
    if (ballX<0){ // player scores
      playerScore++;
      if (playerScore<7) {
        countToStart = 120;
      }
    } else if (ballX>width) { // computer scores
      computerScore++;
      if (computerScore<7) {
        countToStart = 120;
      }
    }
  
      ball.display(move,speed,directionX,directionY,setBall,ballX,ballY);
    
    //creat the the player
    
    // display the ball and displayers
    player.display(playerX,playerY);
    computer.display(computerX,computerY);
    
    
    pComputerX = computerX;
    pComputerY = computerY;
    pPlayerX = playerX;
    pPlayerY = playerY;
    pBallX = ballX;
    pBallY = ballY;
    
      if (computerScore == 7) {  // computer wins
        computerX = width*1/4;
        computerY = height/2;
        playerX = width*3/4;
        playerY = height/2;
        setBall = true;
        move = false;
        ballX = width/2;
        ballY = height/2;
        speed = 0;
        computer.display(computerX,computerY);
        player.display(playerX,playerY);
        ball.display(move,speed,directionX,directionY,setBall,ballX,ballY);
        fill(0,0,0,100); // color for the cover
        rect(0,0,width,height); // draw a half transparent cover
        fill(0,150,0,200); // color for text
        textSize(100); // set text size
        text("YOU LOSE!", width/5, height/2); // display texts
        textSize(50); // set text size smaller
        text("Press N to start a new game", width/10, height*2/3); // display texts
      } else if (playerScore == 7) { // player wins
        computerX = width*1/4;
        computerY = height/2;
        playerX = width*3/4;
        playerY = height/2;
        setBall = true;
        move = false;
        ballX = width/2;
        ballY = height/2;
        speed = 0;
        computer.display(computerX,computerY);
        player.display(playerX,playerY);
        ball.display(move,speed,directionX,directionY,setBall,ballX,ballY);
        fill(0,0,0,100); // color for the cover
        rect(0,0,width,height); // draw a half transparent cover
        fill(0,150,0,200); // color for text
        textSize(100); // set text size
        text("YOU WIN!", width/5, height/2); // display texts
        textSize(50); // set text size smaller
        text("Press N to start a new game", width/10, height*2/3); // display texts
      }
  }
  
  fill(0,150,0,200); // color for scores
  textSize(50); // text size for scores
  text(computerScore,width*2/5,height/10); // show computer's score
  text(playerScore,width*17/30,height/10); // show player's score
//  println("countToStart",countToStart,"setBall:",setBall,"move:",move,"playerX:",playerX,"playerY:",playerY,"computerX:",computerX,"computerY:",computerY); // for debugging
//  println("ballX:",ballX,"ballY:",ballY,"speed:",speed,"computerSpeed:",computerSpeed,"directionX:",directionX,"directionY:",directionY,BPdistance<=BPtouch,BCdistance<=BCtouch);
//  println("playerX:",playerX,"playerY:",playerY); // for debugging
  
} // curly bracket for draw()

void keyPressed() { // run when key is pressed

  // press 'n' to start a new game
  if (key == 'n' || key == 'N') {
    if (!keyDown) { // N wasn't pressed before
      computerScore = 0; // set computer score to 0
      playerScore = 0; // set player score to 0
      keyDown = true; // N is pressed now
      countToStart = 120; // count to restart the game
    } 
  }
  
  // press 's' to save image in the default folder
  if (key == 's' || key == 'S') {
    if (!keyDown) { // S wasn't pressed before
      saveFrame(); // save photo
      keyDown = true; // S is pressed now
    } 
  }
  
  // CHEAT: press '+' to add 1 to player's score
  if (key == '=' || key == '+') {
    if (!keyDown && playerScore<7) { // + wasn't pressed before
      playerScore++; // add 1 to player's score
      keyDown = true; // + is pressed now
    }
  }
  
} // curly bracket for keyPressed()

void keyReleased() {
  keyDown = false; // no key is pressed
  
}

void mousePressed() { // run when mouse is pressed
  mouseDown = true; 
}

void mouseReleased() { // run when mouse is released
  mouseDown = false;
}
