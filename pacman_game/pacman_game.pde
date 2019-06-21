InputInterface input;
Stage stage;

void setup() {
  size(448, 496);
  input = new KeyboardInput();
  stage = new Stage("original", input);
}

void draw() {
  stage.update();
  stage.draw();
}