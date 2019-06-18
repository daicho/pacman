// キャラクターの基底クラス
public abstract class Character {
  private PVector position;     // 現在位置
  private int direction;        // 向き (0:右 1:上 2:左 3:下)
  private int speed;            // 速さ [px/f]

  private PImage[] images;      // アニメーション画像
  private int curAnimetion;     // 現在のアニメーション番号
  private PVector size;         // 画像サイズ
  private int animetionNum;     // アニメーションの数
  private String characterName; // 画像ファイルの読み込みに用いるキャラクター名

  public Character(PVector position) {
    this.position = position;

    // 画像ファイル読み込み
  }

  public PVector getPosition() {
    return this.position;
  }

  public int getDirection() {
    return this.direction;
  }

  public int getSpeed() {
    return this.speed;
  }

  public void setSpeed(int speed) {
    this.speed = speed;
  }

  // 移動
  public void move(Map map) {

  }

  // 特定の方向へ移動できるか
  public boolean canMove(Map map, int direction) {
    return true;
  }

  // 画面描画
  public void draw() {

  }
}