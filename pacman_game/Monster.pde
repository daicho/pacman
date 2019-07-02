// 敵の状態
public enum MonsterStatus {
  Wait,    // 待機
  Release, // 出撃
  Rest,    // 休息モード
  Chase,   // 追いかけモード
  Ijike,   // イジケモード
  Return   // 帰還
}

public abstract class Monster extends Character {
  protected MonsterStatus status = MonsterStatus.Release;    // 状態
  protected Animation[] ijikeAnimations  = new Animation[2]; // イジケ時のアニメーション
  protected Animation[] returnAnimations = new Animation[4]; // 帰還時のアニメーション
  protected int changeMode = 600; // モードが切り替わる間隔 [f]
  protected int changeModeLeft;   // あと何fでモードが切り替わるか
  protected int ijikeTime;        // あと何fでイジケモードが終わるか

  protected Monster(PVector position, int direction, float speed, int interval, String characterName) {
    super(position, direction, speed, interval, characterName);
    this.changeModeLeft = changeMode;

    // イジケ時のアニメーション
    this.ijikeAnimations[0] = new Animation(0, dataPath("characters/ijike-0"));
    this.ijikeAnimations[1] = new Animation(10, dataPath("characters/ijike-1"));

    // 帰還時のアニメーション
    for (int i = 0; i < 4; i++)
      this.returnAnimations[i] = new Animation(0, dataPath("characters/return-" + i));
  }

  public MonsterStatus getStatus() {
    return this.status;
  }

  public void setStatus(MonsterStatus status) {
    this.status = status;
  }

  public int getIjikeTime() {
    return this.ijikeTime;
  }

  public void setIjikeTime(int ijikeTime) {
    this.ijikeTime = ijikeTime;
  }

  // 特定の方向へ移動できるか
  public boolean canMove(Map map, int direction) {
    PVector check = getDirectionVector(direction); // 壁かどうかを判定する座標

    switch(direction) {
    case 0: // 右
      check.add(getMaxPosition().x, getMinPosition().y);

      for (; check.x <= getMaxPosition().x + speed; check.x++) {
        for (; check.y <= getMaxPosition().y; check.y++) {
          MapObject mapObject = map.getObject(check.x, check.y);
          if (mapObject == MapObject.Wall || status != MonsterStatus.Release && status != MonsterStatus.Return && mapObject == MapObject.EnemyDoor)
            return false;
        }
      }

      break;

    case 1: // 上
      check.add(getMinPosition().x, getMinPosition().y);

      for (; check.y >= getMinPosition().y - speed; check.y--) {
        for (; check.x <= getMaxPosition().x; check.x++) {
          MapObject mapObject = map.getObject(check.x, check.y);
          if (mapObject == MapObject.Wall || status != MonsterStatus.Release && status != MonsterStatus.Return && mapObject == MapObject.EnemyDoor)
            return false;
        }
      }

      break;

    case 2: // 左
      check.add(getMinPosition().x, getMinPosition().y);

      for (; check.x >= getMinPosition().x - speed; check.x--) {
        for (; check.y <= getMaxPosition().y; check.y++) {
          MapObject mapObject = map.getObject(check.x, check.y);
          if (mapObject == MapObject.Wall || status != MonsterStatus.Release && status != MonsterStatus.Return && mapObject == MapObject.EnemyDoor)
            return false;
        }
      }

      break;

    case 3: // 下
      check.add(getMinPosition().x, getMaxPosition().y);

      for (; check.y <= getMaxPosition().y + speed; check.y++) {
        for (; check.x <= getMaxPosition().x; check.x++) {
          MapObject mapObject = map.getObject(check.x, check.y);
          if (mapObject == MapObject.Wall || status != MonsterStatus.Release && status != MonsterStatus.Return && mapObject == MapObject.EnemyDoor)
            return false;
        }
      }

      break;
    }

    return true;
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
      checkPosition.add(moveVector);
      ;

      if (canMove(map, checkDirection) && checkPosition.dist(point) < distanceMin) {
        aimDirection = checkDirection;
        distanceMin = checkPosition.dist(point);
      }
    }

    return aimDirection;
  }

  // 進む方向を決定する
  public void decideDirection(Stage stage) {
    PVector aimPoint;

    switch (status) {
    case Wait:
      // 待機中は前後に動く
      if (!canMove(stage.map, direction))
        direction = (direction + 2) % 4;
      break;

    case Release:
      // 出撃中は出撃地点を目指す
      aimPoint = stage.map.getReleasePoint();
      direction = getAimDirection(stage.map, aimPoint);
      break;

    case Ijike:
      // イジケ中はランダムに動く
      aimPoint = new PVector(position.x + random(-1, 1), position.y + random(-1, 1));
      direction = getAimDirection(stage.map, aimPoint);
      break;

    case Return:
      // 帰還中は帰還地点を目指す
      aimPoint = stage.map.getReturnPoint();
      direction = getAimDirection(stage.map, aimPoint);
      break;

    default:
      break;
    }
  }

  // 更新
  public void update(Map map) {
    // 目標地点に到達したら状態遷移
    switch (status) {
    case Release:
      if (round(position.x) == round(map.getReleasePoint().x) && round(position.y) == round(map.getReleasePoint().y))
        status = MonsterStatus.Rest;
      break;

    case Return:
      if (round(position.x) == round(map.getReturnPoint().x) && round(position.y) == round(map.getReturnPoint().y)) {
        changeModeLeft = changeMode;
        status = MonsterStatus.Release;
      }
      break;

    case Ijike:
      break;

    default:
      break;
    }

    // 一定時間経ったらモードを切り替える
    changeModeLeft--;
    if (changeModeLeft < 0) {
      changeModeLeft = changeMode;

      switch (status) {
      case Rest:
        status = MonsterStatus.Chase;
        break;

      case Chase:
        status = MonsterStatus.Rest;
        break;

      default:
        break;
      }
    }

    // 一定時間経ったらイジケモードを解除する
    ijikeTime--;
    if (status == MonsterStatus.Ijike && ijikeTime < 0)
      setStatus(MonsterStatus.Rest);

    // アニメーションを更新
    if (canMove(map, direction)) {
      switch (status) {
      case Wait:
      case Release:
      case Rest:
      case Chase:
        animations[direction].update();
        break;
  
      case Ijike:
        if (ijikeTime > 120)
          ijikeAnimations[0].update();
        else
          ijikeAnimations[1].update();

        break;
  
      case Return:
        returnAnimations[direction].update();
        break;
      }
    }
  }

  // 画面描画
  public void draw() {
    PVector minPostision = getMinPosition();

    switch (status) {
    case Wait:
    case Release:
    case Rest:
    case Chase:
      super.draw();
      break;

    case Ijike:
      if (ijikeTime > 120)
        image(ijikeAnimations[0].getImage(), minPostision.x, minPostision.y);
      else
        image(ijikeAnimations[1].getImage(), minPostision.x, minPostision.y);

      break;

    case Return:
      image(returnAnimations[direction].getImage(), minPostision.x, minPostision.y);
      break;
    }
  }
}