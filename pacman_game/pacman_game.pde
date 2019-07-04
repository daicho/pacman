void setup() {
  size(448, 496);
  Input.setInputInterface(new KeyboardInput()); // 入力設定
  SceneManager.setScene(new Title());
}

void draw() {
  SceneManager.update();
  SceneManager.draw();
}
