InputInterface input;
Stage stage;

void setup() {
  size(224, 248);
  input = new KeyboardInput();
  stage = new Stage("original", input);
}

void draw() {
  stage.update();
  stage.draw();
}