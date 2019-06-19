// キャラクターの基底クラス
public abstract class Character {
  protected PVector position;     // 現在位置
  protected int direction;        // 向き (0:右 1:上 2:左 3:下)
  protected float speed;          // 速さ [px/f]

  protected PImage[][] images;    // アニメーション画像
  protected int curAnimetion;     // 現在のアニメーション番号
  protected PVector size;         // 画像サイズ
  protected int animetionNum;     // アニメーションの数
  protected int interval;         // アニメーションの間隔 [f]
  protected int curInterval;      // あと何fで次のアニメーションにいくか
  protected String characterName; // 画像ファイルの読み込みに用いるキャラクター名

  public Character(PVector position, int direction, float speed, String characterName, int interval) {
    this.position = position;
    this.direction = direction;
    this.speed = speed;
    this.characterName = characterName;
    this.interval = interval;
    this.curAnimetion = 0;

    // 画像ファイルの存在確認
    this.animetionNum = 0;
    while (true) {
      File imageFile = new File(dataPath("characters/" + this.characterName + "-0-" + this.animetionNum + ".png"));
      if (!imageFile.exists())
        break;

      this.animetionNum++;
    }

    // 配列確保
    this.images = new PImage[4][this.animetionNum];

    // 画像ファイル読み込み //<>// //<>//
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < this.animetionNum; j++) { //<>//
        println("i=" + i + " j=" + j);
        this.images[i][j] = loadImage(dataPath("characters/" + this.characterName + "-" + i + "-" + j+ ".png"));
      }
    }

    this.size = new PVector(this.images[0][0].width, this.images[0][0].height);
  }

  // 特定の方向の単位ベクトル
  protected PVector getDirectionVector(int direction) {
    switch (direction) {
      case 0: // 右
        return new PVector(1, 0);

      case 1: // 上
        return new PVector(0, -1);

      case 2: // 左
        return new PVector(-1, 0);

      case 3: // 下
        return new PVector(0, 1);
      
      default:
        return new PVector(0, 0);
    }
  }

  // 左上の座標を取得
  public PVector getMinPosition() {
    return new PVector(this.position.x - this.size.x, this.position.y - this.size.y);
  }

  // 右下の座標を取得
  public PVector getManPosition() {
    return new PVector(this.position.x + this.size.x, this.position.y + this.size.y);
  }

  public PVector getPosition() {
    return this.position;
  }

  public int getDirection() {
    return this.direction;
  }

  public float getSpeed() {
    return this.speed;
  }

  public void setSpeed(float speed, String characterName) {
    this.speed = speed;
  }

  // 移動
  public void move(Map map) {
    PVector moveVector = this.getDirectionVector(this.direction);
    moveVector.mult(this.speed);
    this.position.add(moveVector);
  }

  // 特定の方向へ移動できるか
  public boolean canMove(Map map, int direction) {
    return true;
  }

  // 画面描画
  public void draw() {
    image(images[this.direction][this.curAnimetion], this.getMinPosition().x, this.getMinPosition().y);

    this.curInterval--;
    if (this.curInterval < 0) {
      this.curInterval = this.interval;
      this.curAnimetion = (this.curAnimetion + 1) % this.animetionNum;
    }
  }
}