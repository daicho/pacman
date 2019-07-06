public PFont font;

void setup() {
  size(448, 496);
  font = loadFont("fonts/NuAnkoMochi-Reg-20.vlw"); // フォント
  Input.setInputInterface(new KeyboardInput()); // 入力設定
  
  // ハイスコアロード処理
  String[] scoreData = loadStrings("./data/high_score.txt"); // ハイスコアをロード
  int score = int(scoreData[0]);
  Record.loadHighScore(score); // Recordへ
  
  SceneManager.setScene(new Title()); // タイトル画面をロード
}

void draw() {
  SceneManager.update();
  SceneManager.draw();
}