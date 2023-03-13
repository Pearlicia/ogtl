class Fragment {
  constructor(contxt) {
    this.contxt = contxt;
    this.generate();
  }

  generate() {
    this.style = this.newTet(colors.length - 1);
    this.shape = shapes[this.style];
    this.color = colors[this.style];
    this.x = 0;
    this.y = 0;
    this.descent = false;
  }

  sketch() {
    this.contxt.fillStyle = this.color;
    this.shape.forEach((row, y) => {
      row.forEach((value, x) => {
        if (value > 0) {
          this.contxt.fillRect(this.x + x, this.y + y, 1, 1);
        }
      });
    });
  }

  newTet(t) {
    return Math.floor(Math.random() * t + 1);
  }

  genesis() {
    this.x = this.style === 4 ? 4 : 3;
  }

  advance(k) {
    if (!this.descent) {
      this.x = k.x;
      this.y = k.y;
    }
    this.shape = k.shape;
  }

  dropFast() {
    this.descent = true;
  }

}