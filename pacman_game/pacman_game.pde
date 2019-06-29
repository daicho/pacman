Stage stage;

void setup() {
  size(448, 496);
  stage = new Stage("original", new KeyboardInput());
  stage.draw();
}

void draw() {
  stage.update();
  stage.draw();
}