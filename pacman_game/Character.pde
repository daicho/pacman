// キャラクターの基底クラス //<>//
public abstract class Character extends GameObject {
  protected int direction;         // 向き (0:右 1:上 2:左 3:下)
  protected float speed;           // 速さ [px/f]
  protected Animation[] animations; // アニメーション

  protected Character(PVector position, int direction, float speed, int interval, String characterName) {
    super(position);

    this.direction = direction;
    this.speed = speed;
    this.animations = new Animation[4];

    // アニメーション
    for (int i = 0; i < 4 ;i++)
      animations[i] = new Animation(interval, dataPath("characters/" + characterName + "-" + i));
    this.size = animations[0].getSize();
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

      animations[direction].update();
    }
  }

  // 特定の方向へ移動できるか
  public boolean canMove(Map map, int direction) {
    PVector check = getDirectionVector(direction); // 壁かどうかを判定する座標

    switch(direction) {
    case 0: // 右
      check.add(getMaxPosition().x, getMinPosition().y);
      for (; check.x <= getMaxPosition().x + speed; check.x++)
        for (; check.y <= getMaxPosition().y; check.y++)
          if (map.getObject(check.x, check.y) == MapObject.Wall)
            return false;
      break;

    case 1: // 上
      check.add(getMinPosition().x, getMinPosition().y);
      for (; check.y >= getMinPosition().y - speed; check.y--)
        for (; check.x <= getMaxPosition().x; check.x++)
          if (map.getObject(check.x, check.y) == MapObject.Wall)
            return false;
      break;

    case 2: // 左
      check.add(getMinPosition().x, getMinPosition().y);
      for (; check.x >= getMinPosition().x - speed; check.x--)
        for (; check.y <= getMaxPosition().y; check.y++)
          if (map.getObject(check.x, check.y) == MapObject.Wall)
            return false;
      break;

    case 3: // 下
      check.add(getMinPosition().x, getMaxPosition().y);
      for (; check.y <= getMaxPosition().y + speed; check.y++)
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
      image(animations[direction].getImage(), minPostision.x, minPostision.y);
    }
  }
}