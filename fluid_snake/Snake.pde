class Snake {
  Square[] tail;
  int size;
  float thickness_w = width / grid;
  float thickness_h = height / grid;
  PVector direction = new PVector(1, 0);
  int scale = 20;
  boolean growing = false;
  PVector direction2be;
  boolean dead = false;
  boolean shrink = false;

  Snake() {
    size = 1;
    tail = new Square[1000];
    tail[0] = new Square(new PVector(0, 0), 0);
    direction2be = direction;
  }

  void update() {
    if (shrink) {
      for (int i = 1; i < size; i++) {
        tail[i].update();
      }
      if (tail[size-1].pos.x == tail[0].pos.x && tail[size-1].pos.y == tail[0].pos.y) {
        shrink = false;
        size = 1;
        dead = false;
      }
    } else {
      if (tail[0].pos.x == floor(tail[0].pos.x) && tail[0].pos.y == floor(tail[0].pos.y)) {
        for (int i = 0; i < size; i++) {
          tail[i].pos.x = round(tail[i].pos.x);
          tail[i].pos.y = round(tail[i].pos.y);
          die();
        }
      }
      if (tail[0].pos.x == floor(tail[0].pos.x) && tail[0].pos.y == floor(tail[0].pos.y) && (direction2be.x != direction.x || direction2be.y != direction.y)) {
        direction = direction2be;
        for (int i = 1; i < size; i++) {
          tail[i].targets.add(tail[0].pos.copy());
        }
      }

      tail[0].updateFirst(direction);
      if (!growing) {
        for (int i = 1; i < size; i++) {
          tail[i].update();
        }
      } else {
        for (int i = 1; i < size-1; i++) {
          tail[i].update();
        }
        if (tail[0].pos.x == floor(tail[0].pos.x) && tail[0].pos.y == floor(tail[0].pos.y)) {
          growing = false;
        }
      }
      eat_apple();
    }
  }
  
  void show() {
    fill(0, 255, 0);
    if (dead) {
      fill(255, 0, 0);
    }
    for (int i = 0; i < size; i++) {
      tail[i].show();
    }
    fill(0);
    textSize(30);
    text(size, tail[0].getpos(tail[0].pos).x * thickness_w + thickness_w/2.5, tail[0].getpos(tail[0].pos).y * thickness_h + thickness_h/1.8);
  }

  void set_direction(PVector new_direction) {
    direction2be = new_direction.copy();
  }

  void eat_apple() {
    if (tail[0].getpos(tail[0].pos).x == apple.x && tail[0].getpos(tail[0].pos).y == apple.y) {
      growing = true;
      tail[size] = new Square(tail[size-1].pos.copy(), size);
      for (PVector t : tail[size-1].targets) {
        tail[size].targets.add(t);
      }
      size++;
      PVector newApple = new PVector(floor(random(grid)), floor(random(grid)));
      boolean isAppleShit = false;
      for (int i = 0; i < size; i++) {
        if (tail[i].getpos(tail[i].pos).x == newApple.x && tail[i].getpos(tail[i].pos).y == newApple.y) {
          isAppleShit = true;
        }
      }
      while (isAppleShit) {
        newApple = new PVector(floor(random(grid)), floor(random(grid)));
        isAppleShit = false;
        for (int i = 0; i < size; i++) {
        if (tail[i].getpos(tail[i].pos).x == newApple.x && tail[i].getpos(tail[i].pos).y == newApple.y) {
          isAppleShit = true;
        }
      }
      }
      apple = newApple;
    }
  }

  void die() {
    PVector next = tail[0].getpos(tail[0].pos).copy().add(direction2be);
    for (int i = 1; i < size; i++) {
      if (next.x == tail[i].getpos(tail[i].pos).x && next.y == tail[i].getpos(tail[i].pos).y) {
        dead = true;
        shrink = true;
      }
    }
  }
}
