public final PVector SCREEN_SIZE = new PVector(480, 848); // ゲーム画面サイズ
public PFont font;  // フォント
public PFont font2; // フォント
public Minim minim; // サウンド

void setup() {
  // 画面設定
  //fullScreen(); // フルスクリーン
  size(480, 848); // ウィンドウ
  
  frameRate(30); // フレームレート

  // 入力設定
  Input.setInputInterface(new KeyboardInput()); // キーボード
  //Input.setInputInterface(new MixInput());    // キーボード・アーケード同時対応

  font = createFont("fonts/NuAnkoMochi-Reg.otf", 10);
  font2 = createFont("fonts/NuKinakoMochi-Reg.otf", 10);
  minim = new Minim(this);

  // ハイスコアをロード
  String dataName = "ranking.txt";
  Record.setFilePath(dataPath(dataName));
  Record.loadRanking();

  SceneManager.setScene(new Title()); // タイトル画面をロード
  //SceneManager.setScene(new Result(100000, 2, false));
}

void draw() {
  // 画面描画
  translate((width - SCREEN_SIZE.x) / 2, (height - SCREEN_SIZE.y) / 2);
  SceneManager.update();
  SceneManager.draw();
}
