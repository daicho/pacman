public PFont font;

void setup() {
  size(448, 496);
  font = loadFont("fonts/NuAnkoMochi-Reg-20.vlw"); // フォント
  Input.setInputInterface(new KeyboardInput()); // 入力設定
  
  String dataName = "high_score.txt";
  // ハイスコアデータロード処理
  Record.loadFilePath(dataPath(dataName));
  // ハイスコアロード処理
  Record.loadHighScore();

  SceneManager.setScene(new Title()); // タイトル画面をロード
}

void draw() {
  SceneManager.update();
  SceneManager.draw();
}