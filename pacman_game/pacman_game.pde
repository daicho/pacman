public final PVector SCREEN_SIZE = new PVector(480, 848); // ゲーム画面サイズ

public PFont font;  // フォント
public PFont font2; // フォント
public Minim minim; // サウンド
public DataBase db; // データベース
public int highScore = 0; // ハイスコア

void setup() {
  // ウィンドウ設定
  size(480, 848);
  this.surface.setTitle("BOTCH-MAN");
  this.surface.setIcon(loadImage("images/arai-3-0.png"));
  
  // 画面設定
  frameRate(30);
  noCursor();
  
  // 入力設定
  //Input.setInputInterface(new MixInput());    // キーボード・アーケード同時対応
  Input.setInputInterface(new KeyboardInput()); // キーボード
  
  // 読み込み
  font = createFont("fonts/NuAnkoMochi-Reg.otf", 10);
  font2 = createFont("fonts/NuKinakoMochi-Reg.otf", 10);
  minim = new Minim(this);
  db = new DataBase("pacman");
  
  // タイトル画面をロード
  SceneManager.setScene(new Title());
}

void draw() {
  // 画面描画
  SceneManager.update();
  SceneManager.draw();
}
