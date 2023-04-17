class Square {
  PVector pos;
  PVector dir;
  float thickness_w = width/grid;
  float thickness_h = height/grid;
  ArrayList<PVector> targets = new ArrayList<PVector>();
  int number;

  Square(PVector pos_, int number_) {
    pos = pos_;
    number = number_;
  }

  void show() {
    noStroke();
    PVector showpos = getpos(pos);
    if (showpos.x * thickness_w + thickness_w > width) {
      rect(showpos.x * thickness_w, showpos.y * thickness_h, width - showpos.x * thickness_w, thickness_h);
      rect(0, showpos.y * thickness_w, showpos.x * thickness_h + thickness_w - width, thickness_h);
    } else if (showpos.y * thickness_h + thickness_h > height) {
      rect(showpos.x * thickness_w, showpos.y * thickness_h, thickness_w, height - showpos.y * thickness_h);
      rect(showpos.x * thickness_w, 0, thickness_w, showpos.y * thickness_h + thickness_h - height);
    } else {
      rect(showpos.x * thickness_w, showpos.y * thickness_h, thickness_w, thickness_h);
    }
    for (PVector t : targets) {
      rect(getpos(t).x * thickness_w, getpos(t).y * thickness_h, thickness_w, thickness_h);
    }
  }

  void update() {
    if (targets.size() > 0) {
      dir = (targets.get(0).copy().sub(pos));
    } else {
      dir = (snake.tail[0].pos.copy().sub(pos));
    }
    if (abs(dir.x) > abs(dir.y)) {
      dir.y = 0;
    } else {
      dir.x = 0;
    }
    pos.add(dir.copy().normalize().mult(speed));
    if (targets.size() > 0) {
      if (pos.x == targets.get(0).x && pos.y == targets.get(0).y) {
        targets.remove(targets.get(0));
      }
    }
  }

  void updateFirst(PVector direction) {
    dir = direction;
    pos.add(direction.copy().normalize().mult(speed));
  }

  PVector getpos(PVector pos) {
    PVector newpos = pos.copy();
    while (newpos.x * thickness_w >= width) {
      newpos.x -= width / thickness_w;
    }
    while (newpos.x * thickness_w < 0) {
      newpos.x += width / thickness_w;
    }
    while (newpos.y * thickness_h >= height) {
      newpos.y -= height / thickness_h;
    }
    while (newpos.y * thickness_h < 0) {
      newpos.y += height / thickness_h;
    }
    return newpos;
  }
}
