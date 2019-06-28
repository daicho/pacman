// キャラクターの基底クラス //<>//
public abstract class Character extends GameObject {
  protected int direction;        // 向き (0:右 1:上 2:左 3:下)
  protected float speed;          // 速さ [px/f]
  protected PImage[][] images;    // アニメーション画像
  protected String characterName; // 画像ファイルの読み込みに用いるキャラクター名
  protected int curAnimetion;     // 現在のアニメーション番号
  protected int animetionNum;     // アニメーションの数
  protected int interval;         // アニメーションの間隔 [f]
  protected int intervalLeft;     // あと何fで次のアニメーションにいくか
  protected int mapsizewidth = 448;     // マップの横幅

  protected Character(PVector position, int direction, float speed, String characterName, int interval) {
    super(position);

    this.direction = direction;
    this.speed = speed;
    this.characterName = characterName;
    this.curAnimetion = 0;
    this.interval = interval;
    this.intervalLeft = interval;

    // 画像ファイルの存在確認
    this.animetionNum = 0;
    while (true) {
      File imageFile = new File(dataPath("characters/" + characterName + "-0-" + animetionNum + ".png"));
      if (!imageFile.exists())
        break;

      this.animetionNum++;
    }

    // 画像ファイル読み込み
    this.images = new PImage[4][animetionNum];

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < animetionNum; j++) {
        this.images[i][j] = loadImage(dataPath("characters/" + characterName + "-" + i + "-" + j + ".png"));
      }
    }

    this.size = new PVector(images[0][0].width, images[0][0].height);
  }

  public int getDirection() {
    return this.direction;
  }

  public float getSpeed() {
    return this.speed;
  }

  public void setSpeed(float speed) {
    this.speed = speed;
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

  // 移動
  public void move(Map map) {
    if (canMove(map, direction)) {
      PVector moveVector = getDirectionVector(direction);
      //PVector checkworp; // ワープするかどうかを判定する座標
      
      //ワープに入った時
      switch(direction) {
        case 0: // 右
          //checkworp = new PVector(getMaxPosition().x + speed, getMinPosition().y);
          if (position.x > mapsizewidth)
            position.x = 1;
          break;

        case 2: // 左
          //checkworp = new PVector(getMinPosition().x - speed, getMinPosition().y);
          if (position.x < 0)
            position.x = mapsizewidth - 1;
          break;
      }
      
      moveVector.mult(speed);
      position.add(moveVector);

      // アニメーションを更新
      this.intervalLeft--;
      if (intervalLeft < 0) {
        intervalLeft = interval;
        curAnimetion = (curAnimetion + 1) % animetionNum;
      }
    }
  }

  // 特定の方向へ移動できるか
  public boolean canMove(Map map, int direction) {
    PVector check; // 壁かどうかを判定する座標

    switch(direction) {
      case 0: // 右
        check = new PVector(getMaxPosition().x + speed, getMinPosition().y);
        for (; check.y <= getMaxPosition().y; check.y++)
          if (map.getObject(check.x, check.y) == MapObject.Wall)
            return false;
        break;

      case 1: // 上
        check = new PVector(getMinPosition().x, getMinPosition().y - speed);
        for (; check.x <= getMaxPosition().x; check.x++)
          if (map.getObject(check.x, check.y) == MapObject.Wall)
            return false;
        break;

      case 2: // 左
        check = new PVector(getMinPosition().x - speed, getMinPosition().y);
        for (; check.y <= getMaxPosition().y; check.y++)
          if (map.getObject(check.x, check.y) == MapObject.Wall)
            return false;
        break;

      case 3: // 下
        check = new PVector(getMinPosition().x, getMaxPosition().y + speed);
        for (; check.x <= getMaxPosition().x; check.x++)
          if (map.getObject(check.x, check.y) == MapObject.Wall)
            return false;
        break;
    }

    return true;
  }

  // 画面描画
  public void draw() {
    if (exist) {
      PVector minPostision = getMinPosition();
      image(images[direction][curAnimetion], minPostision.x, minPostision.y);
    }
  }
}