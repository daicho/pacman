// キャラクターの基底クラス
public abstract class Character extends GameObject {
  protected int direction; // 向き (0:右 1:上 2:左 3:下)
  protected float speed;   // 速さ [px/f]
  protected Animation[] animations = new Animation[4]; // アニメーション

  protected Character(PVector position, int direction, float speed, String characterName) {
    super(position);

    this.direction = direction;
    this.speed = speed;

    // アニメーション
    for (int i = 0; i < 4; i++)
      animations[i] = new Animation(characterName + "-" + i);
    this.size = animations[0].getSize();
  }

  public int getDirection() {
    return this.direction;
  }

  public void setDirection(int direction) {
    this.direction = direction;
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
      moveVector.mult(speed);
      position.add(moveVector);

      // ワープトンネル
      PVector mapSize = map.getSize();

      switch(direction) {
      case 0: // 右
        if (position.x >= mapSize.x)
          position.x -= mapSize.x;
        break;

      case 1: // 上
        if (position.y < 0)
          position.y += mapSize.y;
        break;

      case 2: // 左
        if (position.x < 0)
          position.x += mapSize.x;
        break;

      case 3: // 下
        if (position.y >= mapSize.y)
          position.y -= mapSize.y;
        break;
      }
    }
  }

  // 特定の方向へ移動できるか
  public boolean canMove(Map map, int direction) {

    PVector check = getDirectionVector(direction); // 壁かどうかの判定に使用する座標

    for (; check.mag() <= getDirectionVector(direction).mult(speed).mag(); check.add(getDirectionVector(direction))) {
      MapObject mapObject = map.getObject(check.x + getPosition().x, check.y + getPosition().y);
       if (mapObject == MapObject.Wall || mapObject == MapObject.MonsterDoor)
          return false;
    }

    return true;
  }

  // 進む方向を決定する
  public abstract void decideDirection(Stage stage);

  // 更新
  public void update(Map map) {
    if (canMove(map, direction))
      animations[direction].update();
  }

  // 画面描画
  public void draw() {
    PVector minPostision = getMinPosition();
    image(animations[direction].getImage(), minPostision.x, minPostision.y);
  }
}
