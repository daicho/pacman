public final PVector SCREEN_SIZE = new PVector(448, 496); // ゲーム画面サイズ
public PFont font;  // フォント
public Minim minim; // サウンド

void setup() {
  //fullScreen(); // フルスクリーン
  size(448, 496); // ウィンドウ

  font = loadFont("fonts/NuAnkoMochi-Reg-20.vlw");
  minim = new Minim(this);

  // ハイスコアをロード
  String dataName = "ranking.txt";
  Record.setFilePath(dataPath(dataName));
  Record.loadRanking();

  Input.setInputInterface(new KeyboardInput()); // 入力設定
  SceneManager.setScene(new Title());           // タイトル画面をロード
}

void draw() {
  // 画面描画
  translate((width - SCREEN_SIZE.x) / 2, (height - SCREEN_SIZE.y) / 2);
  SceneManager.update();
  SceneManager.draw();
}
