// 敵の状態
public enum MonsterStatus {
  Wait,    // 待機
  Release, // 出撃
  Active,  // 活動
  Return   // 帰還
}

// 敵のモード
public enum MonsterMode {
  Rest,  // 休息モード
  Chase, // 追いかけモード
  Ijike  // イジケモード
}

public abstract class Monster extends Character {
  protected MonsterStatus status = MonsterStatus.Wait;       // 状態
  protected MonsterMode mode = MonsterMode.Rest;             // モード
  protected Animation[] ijikeAnimations = new Animation[2];  // イジケ時のアニメーション
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

  public MonsterMode getMode() {
    return this.mode;
  }

  public void setMode(MonsterMode mode) {
    this.mode = mode;
    changeModeLeft = changeMode;

    if (mode == MonsterMode.Ijike) {
      ijikeAnimations[0].reset();
      ijikeAnimations[1].reset();
    }
  }

  public int getIjikeTime() {
    return this.ijikeTime;
  }

  public void setIjikeTime(int ijikeTime) {
    this.ijikeTime = ijikeTime;
  }

  // 特定の方向へ移動できるか
  public boolean canMove(Map map, int direction) {

    PVector check = getDirectionVector(direction); // 壁かどうかの判定に使用する座標

    for (; check.mag() <= getDirectionVector(direction).mult(speed).mag(); check.add(getDirectionVector(direction))) {
      MapObject mapObject = map.getObject(check.x + getPosition().x, check.y + getPosition().y);
      if (mapObject == MapObject.Wall || status != MonsterStatus.Release && status != MonsterStatus.Return && mapObject == MapObject.MonsterDoor)
        return false;
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

    case Active:
      if (mode == MonsterMode.Ijike) {
        // イジケ中はランダムに動く
        aimPoint = new PVector(position.x + random(-1, 1), position.y + random(-1, 1));
        direction = getAimDirection(stage.map, aimPoint);
      }
      break;

    case Return:
      // 帰還中は帰還地点を目指す
      aimPoint = stage.map.getReturnPoint();
      direction = getAimDirection(stage.map, aimPoint);
      break;
    }
  }

  // 更新
  public void update(Map map) {
    // 目標地点に到達したら状態遷移
    switch (status) {
    case Release:
      if (round(position.x) == round(map.getReleasePoint().x) && round(position.y) == round(map.getReleasePoint().y)) {
        setStatus(MonsterStatus.Active);
      }
      break;

    case Return:
      if (round(position.x) == round(map.getReturnPoint().x) && round(position.y) == round(map.getReturnPoint().y)) {
        setStatus(MonsterStatus.Release);
        setMode(MonsterMode.Rest);
      }
      break;

    default:
      break;
    }

    // 一定時間経ったらモードを切り替える
    changeModeLeft--;
    if (changeModeLeft < 0) {
      changeModeLeft = changeMode;

      switch (mode) {
      case Rest:
        setMode(MonsterMode.Chase);
        break;

      case Chase:
        setMode(MonsterMode.Rest);
        break;

      default:
        break;
      }
    }

    // 一定時間経ったらイジケモードを解除する
    ijikeTime--;
    if (mode == MonsterMode.Ijike && ijikeTime < 0) {
      setMode(MonsterMode.Rest);
    }

    // アニメーションを更新
    if (canMove(map, direction)) {
      switch (status) {
      case Wait:
      case Release:
      case Active:
        if (mode == MonsterMode.Ijike) {
          if (ijikeTime > 120)
            ijikeAnimations[0].update();
          else
            ijikeAnimations[1].update();
        } else {
          animations[direction].update();
        }
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
    case Active:
      if (mode == MonsterMode.Ijike) {
        if (ijikeTime > 120)
          image(ijikeAnimations[0].getImage(), minPostision.x, minPostision.y);
        else
          image(ijikeAnimations[1].getImage(), minPostision.x, minPostision.y);
      } else {
        super.draw();
      }
      break;

    case Return:
      image(returnAnimations[direction].getImage(), minPostision.x, minPostision.y);
      break;
    }
  }
}
