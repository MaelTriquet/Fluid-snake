Snake snake;
PVector apple;
int grid = 10;
float square;
float speed = pow(.5, 3);
void setup() {
  size(1000, 1000);
  noStroke();
  snake = new Snake();
  apple = new PVector(floor(random(grid)), floor(random(grid)));
  square = width / grid;
}

void draw() {
  background(0);
  snake.update();
  snake.show();
  fill(230, 80, 40);
  rect(apple.x * square, apple.y * square, square, square);
}

void keyPressed() {
  switch(keyCode) {
  case UP:
    snake.set_direction(new PVector(0, -1));
    break;
  case DOWN:
    snake.set_direction(new PVector(0, 1));
    break;
  case LEFT:
    snake.set_direction(new PVector(-1, 0));
    break;
  case RIGHT:
    snake.set_direction(new PVector(1, 0));
    break;
  }
}
