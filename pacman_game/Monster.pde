// 敵の状態
public enum MonsterStatus {
  Wait,  // 待機
  Rest,  // 休息モード
  Chase, // 追いかけモード
  Ijike, // イジケモード
  Return // 帰還
}

public abstract class Monster extends Character {
  protected MonsterStatus status;        // 状態
  protected Animation[] ijikeAnimations; // イジケモード時のアニメーション

  protected Monster(PVector position, int direction, float speed, int interval, String characterName) {
    super(position, direction, speed, interval, characterName);

    this.status = MonsterStatus.Rest;
    this.ijikeAnimations = new Animation[2];

    // イジケモード時のアニメーション
    this.ijikeAnimations[0] = new Animation(0,  dataPath("characters/" + characterName + "-ijike-0"));
    this.ijikeAnimations[1] = new Animation(10, dataPath("characters/" + characterName + "-ijike-1"));
  }

  public MonsterStatus getStatus() {
    return this.status;
  }

  public void setStatus(MonsterStatus status) {
    this.status = status;
  }

  // 目標地点に進むための方向を返す
  protected int getAimDirection(Map map, PVector point) {
    int aimDirection = 0;
    float distanceMin = map.size.mag();
    boolean canForward = canMove(map, direction);

    for (int i = 0; i < 4; i++) {
      // 前進できるなら後退しない
      if (canForward)
        if (i == 2) continue;

      // 各方向に進んだときに目標地点との距離が最短となる方向を探す
      int checkDirection = (direction + i) % 4;

      PVector checkPosition = position.copy();
      PVector moveVector = getDirectionVector(checkDirection);
      moveVector.mult(speed);
      checkPosition.add(moveVector);;

      if (canMove(map, checkDirection) && checkPosition.dist(point) < distanceMin) {
        aimDirection = checkDirection;
        distanceMin = checkPosition.dist(point);
      }
    }

    return aimDirection;
  }

  // 画面描画
  public void draw() {
    switch (status) {
    case Wait:
    case Rest:
    case Chase:
      super.draw();
      break;

    case Ijike:
      PVector minPostision = getMinPosition();
      image(ijikeAnimations[0].getImage(), minPostision.x, minPostision.y);
      break;

    case Return:
      break;
    }
  }
}