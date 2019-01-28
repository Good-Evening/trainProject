PImage train;
PImage othertrains;
PImage othertrains2;
PImage tracks;
PImage point;
PImage mlgtrain;
PImage explosionImg;
PImage yuno;
PImage face;
PImage powerup;
float rand = (int)random(0, 5);
int x = 71; 
int y = 200;
float train2x = 171;
float train2y = 0;
float train3x = 171;
float train3y = 0;
int score = 0; 
int lives = 3;
int traintype = 0;
float pointx = 171;
float pointy = 0;
float alpha=0;
float powerupx = 171;
float powerupy = 0;
float powerupTimer=0;
int state = 0;
void setup() {
  size(400, 400);
  train = loadImage("http://i.imgur.com/qU913hg.png");
  othertrains = loadImage("http://i.imgur.com/LSWuUJr.png?1");
  tracks = loadImage("http://i.imgur.com/X48ZBj3.png");
  point = loadImage("http://i.imgur.com/dTEmzFG.png");
  mlgtrain = loadImage("http://i.imgur.com/HH004rt.png");
  explosionImg = loadImage("http://i.imgur.com/56rIh00.png");
  yuno = loadImage("http://i.imgur.com/qujAe3P.png");
  face = loadImage("http://i.imgur.com/6mVYgGe.png");
  othertrains2 = loadImage("http://i.imgur.com/LSWuUJr.png?1");
  powerup = loadImage("http://i.imgur.com/KPvHrNM.png");
}
void draw() {
  if (state == 0) {
    state0();
  } else if (state ==1 ) {
    background(131, 1, 1);
    fill(0, alpha);
    alpha+= 0.5;
    textSize(33);
    text("Your train could only\n withstand \n three train hits.", 0, 30);
    image(yuno, 310, 110);
    image(face, 370, 370);
    textSize(25);
    text("Vote for me or the trains\n will come after you.\n 2spooky4me.", 0, 200);
  }
}

void state0() {

  addTrains();
  coordinates();
  train2y += 5;
  train3y += 5;
  powerupy += 9;
  pointy += 5;
  trainLoop();

  explosion();

  text("You have gained \n"+score+" gears.", 280, 20);
  text("You have \n"+lives+" lives left.", 280, 50);

  ifTouching();
  if (lives <= 0) {
    state = 1;
  }
  text(traintype, 20, 20);
  if (powerupTimer>0)powerupTimer--;
  if (powerupTimer==0) traintype=0;
  text(powerupTimer, 20, 40);
}

void keyPressed() {
  if (state==0) {
    if (key == CODED && keyCode == RIGHT && x < 271) {
      x += 50; // WORK ON THIS
    } else if (key ==  CODED && keyCode == LEFT && x > 71) {
      x -= 50; // WORK ON THIS
    }
    if (key == CODED && keyCode == UP && y > 0) {
      y -= 5; // WORK ON THIS
    } else if (key ==  CODED && keyCode == DOWN && y < height ) {
      y += 5; // WORK ON THIS
    }
  }
}

void addTrains() {
  if (frameCount % 240 == 0) {
    train2x = rand*50 +71; 
    train2y = 0;
  }
  if (frameCount % 200 == 0) {
    train3x = rand*50 +71; 
    train3y = 0;
  }
  if (frameCount % 100 == 0) {
    pointx = rand*50 +71; 
    pointy = 0;
  }
  if (frameCount % 300 == 0) {
    powerupx = rand*50 +71; 
    powerupy = 0;
  }
}
void coordinates() {
  imageMode(CENTER);
  background(64, 29, 2);
  rect(0, 0, 50, 500);
  fill(113, 106, 101);
  image(tracks, 70, 250);
  image(tracks, 120, 250); 
  image(tracks, 170, 250);
  image(tracks, 220, 250);
  image(tracks, 270, 250);
  image(train, x, y);
  image(othertrains, train2x, train2y);
  image(point, pointx, pointy);
  image(othertrains2, train3x, train3y);
  image(powerup, powerupx, powerupy);
  rect(400, 20, 30, 60);
  fill(129, 126, 126);
}

void trainLoop() {
  if (train2y>height) {
    train2x=randomPosition();
    train2y = 0;  
    train2y += 2;
    if (train2y > 400) {
      train2y = 0;
    }
  }
  if (train3y>height) {
    train3x=randomPosition();
    train3y = 0;  
    train3y += 2;
    if (train3y > 400) {
      train3y = 0;
    }
  }
  if (pointy>height) {
    pointx = randomPosition();
    pointy = 0;  
    pointy += 2;
    if (pointy > 400) {
      pointy = 0;
    }
  }
  if (powerupy>height) {
    powerupx = randomPosition();
    powerupy = 0;  
    powerupy += 2;
    if (powerupy > 400) {
      powerupy = 0;
    }
  }
}

void ifTouching() {
  if (traintype == 0) {
    train = loadImage("http://i.imgur.com/qU913hg.png");
    if (abs(train3x-x) < 10 && abs(train3y-y) < 10) {
      explodex=train3x;
      explodey=train3y;
      train3y = -100000;
      explodeTimer=50;
      lives--;
    }
    if (abs(train2x-x) < 10 && abs(train2y-y) < 10) {
      explodex=train2x;
      explodey=train2y;
      train2y = -100000;
      explodeTimer=50;
      lives--;
    }
  } else if (traintype == 1) {
    train = loadImage("http://i.imgur.com/HH004rt.png");
    if (abs(train3x-x) < 10 && abs(train3y-y) < 10) {
      explodex=train3x;
      explodey=train3y;
      train3y = -100000;
      explodeTimer=50;
    }
    if (abs(train2x-x) < 10 && abs(train2y-y) < 10) {
      explodex=train2x;
      explodey=train2y;
      train2y = -100000;
      explodeTimer=50;
    }
  }
  if (abs(pointx-x) < 2 && abs(pointy-y) < 5) {
    pointy = -100000;
    score++;
  }
  if (abs(powerupx-x) < 2 && abs(powerupy-y) < 5) {
    powerupy = -100000;
    traintype = 1;
    powerupTimer=100;
  }
} 
int randomPosition() {
  int rand = (int)random(1, 5);
  if (rand == 1) {
    return 71;
  } else if (rand == 2) {
    return 121;
  } else if (rand == 3) {
    return 171;
  } else if (rand ==  4) {
    return 221;
  } else return 271;
}

int explodeTimer=0;
float explodex=0;
float explodey=0;

void explosion() {
  if (explodeTimer>0) {
    image(explosionImg, explodex, explodey);
  }
  explodeTimer--;
}

