public PFont font;
public Minim minim;

void setup() {
  size(448, 496);
  font = loadFont("fonts/NuAnkoMochi-Reg-20.vlw"); // フォント
  minim = new Minim(this); // サウンド

  // ハイスコアをロード
  String dataName = "ranking.txt";
  Record.setFilePath(dataPath(dataName));
  Record.loadRanking();

  Input.setInputInterface(new KeyboardInput()); // 入力設定
  SceneManager.setScene(new Title()); // タイトル画面をロード
}

void draw() {
  SceneManager.update();
  SceneManager.draw();
}
