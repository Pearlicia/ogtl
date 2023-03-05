class Fragment {
  constructor(contxt) {
    this.contxt = contxt;
    this.spawn();
  }

  generate() {
    this.typeId = this.newTet(colors.length - 1);
    this.shape = shapes[this.typeId];
    this.color = colors[this.typeId];
    this.x = 0;
    this.y = 0;
    this.hardDropped = false;
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

  newTet(types) {
    return Math.floor(Math.random() * types + 1);
  }

  genesis() {
    this.x = this.typeId === 4 ? 4 : 3;
  }

  advance(p) {
    if (!this.hardDropped) {
      this.x = p.x;
      this.y = p.y;
    }
    this.shape = p.shape;
  }

  hardDrop() {
    this.hardDropped = true;
  }

}