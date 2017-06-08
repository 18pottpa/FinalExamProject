# FinalExamProject
//Patrick Potter
// 6-8-17
//Final

Snake s;
int scl = 20;
String status = "";
PVector food;
boolean gotFood;
boolean alive;
int finalScore;
int frame = (int)random(2, 25);
int first = (int)random(1, 50);
int second = (int)random (1, 50);
int answer;
int userInput;

void setup() {
  size(600, 600);
  s = new Snake();
  alive = true;
  setFoodLocation();
}

void draw() {
  background(51);
  // how to control the snake
  if (alive == true) {
    if (keyCode == UP) {
      s.dir(0, -1);
    }
    if (keyCode == DOWN) {
      s.dir(0, 1);
    }
    if (keyCode == LEFT) {
      s.dir(-1, 0);
    }
    if (keyCode == RIGHT) {
      s.dir(1, 0);
    }
    text("Score: " + s.total, 545, 20);
    s.checkForPulse();
    s.update();
    s.show();
    gotFood = s.eat(food);
    if (gotFood == true) {
      setFoodLocation();
    }
    fill(255, 0, 100);
    rect(food.x, food.y, scl, scl);
    text((first + " + " + second + " = "), 300, 300);
    status = "length: " + s.total;
  } else {
    if (alive == false) {
      // print this at the end of the game
      text("Game is Over! ", 300, 290);
      text("Final Score:  " + finalScore, 300, 310);
      text("Press X To Restart", 300, 330);
    }
    if (alive == false && keyPressed == true && key == 'x') {
      alive = true;
      s = new Snake();
    }
  }
}


//take two random ints, adds them together and stores answer. This also deplays the equation in the game for you to answer.
void setFoodLocation() {
  int cols = width/scl;
  int rows = height/scl;
  food = new PVector(floor(random(cols)), floor(random(rows)));
  food.mult(scl);
  int frame = (int)random(2, 20);
  frameRate(frame);
  first = (int)random(1, 4);
  second = (int)random (1, 4);
  answer = first + second;
  userInput = answer;
  println(answer);
}
// listens for the answer and key pressed, if they are the same take a block off the snake, and increases score by one, if wrong take one block off snake if greater than two blocks, and decrease score by one.
// also prints the answer on the bottom of the code if you got it right or wrong.
void keyPressed() {
  if (key == '1' || key == '2' || key == '3' || key == '4' ||key == '5' ||key == '6' ||key == '7' ||key == '8') {
    int submitted = Character.getNumericValue(key);
    if (submitted == answer) {
      s.total = s.total + 1;
      print("Right");
    } else {
      if (!s.tail.isEmpty()) {
        s.total = s.total -1;
        s.tail.remove(s.tail.size()-1);
        print("wrong");
      }
    }
  }
}

class Snake {
  float x = 0;
  float y = 0;
  float xspeed = 1;
  float yspeed = 0;
  int total = 0;
  ArrayList<PVector> tail = new ArrayList<PVector>();
  Snake() {
  }

  boolean eat(PVector pos) {
    float d = dist(x, y, pos.x, pos.y);
    if (d < 1) {
      total++;
      return true;
    } else {
      return false;
    }
  }

  void dir(float x, float y) {
    xspeed = x;
    yspeed = y;
  }

  void checkForPulse() {
    for (int i = 0; i < tail.size(); i++) {
      PVector pos = tail.get(i);
      float d = dist(x, y, pos.x, pos.y);
      if (d < 1) {
        finalScore = total;
        total = 0;
        alive = false;
        tail.clear();
      }
    }
  }

  void update() {
    if (total > 0) {
      if (total == tail.size() && !tail.isEmpty()) {
        tail.remove(0);
      }
      tail.add(new PVector(x, y));
    }
    x = x + xspeed*scl;
    y = y + yspeed*scl;
    // If you hold the "z" key when the snake is going towards the edge it goes through and comes out the opposite side wtihout dying.
    if (keyPressed == true && key == 'z') {
      if ( x > width-scl) {
        x = 0;
      }
      if (x < 0) {
        x = 600;
      }
      if ( y > height-scl) {
        y = 0;
      }
      if ( y < 0) {
        y = 600;
      }
    } else { 
      x = constrain(x, 0, width-scl);
      y = constrain(y, 0, height-scl);
    }
  }

  void show() {
    fill(255);
    for (PVector v : tail) {
      rect(v.x, v.y, scl, scl);
    }
    rect(x, y, scl, scl);
  }

  int getTotal() {
    return total;
  }
}
