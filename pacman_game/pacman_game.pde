public PFont font;
public Minim minim;

void setup() {
  size(448, 496);
  font = loadFont("fonts/NuAnkoMochi-Reg-20.vlw"); // フォント

  String dataName = "high_score.txt";
  // ハイスコアデータロード処理
  Record.loadFilePath(dataPath(dataName));
  // ハイスコアロード処理
  Record.loadRankScore();

  Input.setInputInterface(new KeyboardInput()); // 入力設定
  SceneManager.setScene(new Title()); // タイトル画面をロード

  minim = new Minim(this);  // サウンド
}

void draw() {
  SceneManager.update();
  SceneManager.draw();
}
