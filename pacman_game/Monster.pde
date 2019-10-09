// 敵の状態 //<>// //<>//
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

// 敵のスピード
public enum MonsterSpeed {
  Wait,    // 待機
  Release, // 出撃
  Return,  // 帰還
  Rest   , // 休憩モード
  Chase,   // 追いかけモード
  Ijike    // イジケモード
}

public abstract class Monster extends Character {
  protected MonsterStatus status = MonsterStatus.Wait;       // 状態
  protected MonsterMode mode = MonsterMode.Rest;             // モード
  protected int ijikeStatus = 0;                             // 0:通常 1:終わりそう
  protected Animation[] ijikeAnimations = new Animation[2];  // イジケ時のアニメーション
  protected Animation[] returnAnimations = new Animation[4]; // 帰還時のアニメーション
  protected HashMap<MonsterSpeed, Float> speeds;

  protected Monster(PVector position, int direction, HashMap<MonsterSpeed, Float> speeds, String characterName) {
    super(position, direction, speeds.get(MonsterSpeed.Wait), characterName);
    this.speeds = speeds;

    // イジケ時のアニメーション
    this.ijikeAnimations[0] = new Animation("ijike-0");
    this.ijikeAnimations[1] = new Animation("ijike-1");

    // 帰還時のアニメーション
    for (int i = 0; i < 4; i++)
      this.returnAnimations[i] = new Animation("return-" + i);
  }

  protected void updateSpeed() {
    switch (status) {
    case Wait:
      speed = speeds.get(MonsterSpeed.Wait);
      break;

    case Release:
      speed = speeds.get(MonsterSpeed.Release);
      break;

    case Return:
      speed = speeds.get(MonsterSpeed.Return);
      break;

    case Active:
      switch (mode) {
      case Rest:
        speed = speeds.get(MonsterSpeed.Rest);
        break;

      case Chase:
        speed = speeds.get(MonsterSpeed.Chase);
        break;

      case Ijike:
        speed = speeds.get(MonsterSpeed.Ijike);
        break;
      }
    }
  }

  public MonsterStatus getStatus() {
    return this.status;
  }

  public void setStatus(MonsterStatus status) {
    this.status = status;
    updateSpeed();
  }

  public MonsterMode getMode() {
    return this.mode;
  }

  public void setMode(MonsterMode mode) {
    this.mode = mode;
    updateSpeed();

    if (mode == MonsterMode.Ijike) {
      ijikeStatus = 0;
      ijikeAnimations[0].reset();
      ijikeAnimations[1].reset();
    }
  }

  public int getIjikeStatus() {
    return this.ijikeStatus;
  }

  public void setIjikeStatus(int ijikeStatus) {
    this.ijikeStatus = ijikeStatus;
  }

  // 移動
  public void move(Map map) {
    if (status != MonsterStatus.Return) {
      // 曲がれたら曲がる、曲がれなかったら直進、前進できるなら後退しない
      PVector forwardMove = canMove(map, direction);
      PVector nextMove = canMove(map, nextDirection);

      if (nextMove.mag() != 0 && (forwardMove.mag() == 0 || (direction + 2) % 4 != nextDirection))
        direction = nextDirection;
      else
        nextMove = canMove(map, direction);
      position.add(nextMove);
    } else {
      for (float t = 0; t < speed; t++) {
        float moveDistance;
        PVector moveVector;

        // 1マスずつ進みながらチェック
        if (t + 1 <= int(speed))
          moveDistance = 1;
        else
          moveDistance = speed - t;

        // 進むべき方向に進む
        direction = map.getReturnRoute(position);
        moveVector = getDirectionVector(direction);
        moveVector.mult(moveDistance);
        position.add(moveVector);

        // 巣に到着
        if (round(position.x) == round(map.getReturnPoint().x) && round(position.y) == round(map.getReturnPoint().y))
          break;
      }
    }

    // ワープトンネル、道の真ん中を進むように調整
    switch (direction) {
    case 0: // 右
      position.y = round(position.y);
      if (position.x >= map.getSize().x)
        position.x -= map.getSize().x;
      break;

    case 1: // 上
      position.x = round(position.x);
      if (position.y < 0)
        position.y += map.getSize().y;
      break;

    case 2: // 左
      position.y = round(position.y);
      if (position.x < 0)
        position.x += map.getSize().x;
      break;

    case 3: // 下
      position.x = round(position.x);
      if (position.y >= map.getSize().y)
        position.y -= map.getSize().y;
      break;
    }
  }

  // 特定の方向へ移動できるか
  public PVector canMove(Map map, int aimDirection) {
    boolean turnFlag = false;
    PVector result = new PVector(0, 0);

    for (float t = 0; t < speed; t++) {
      float moveDistance;
      PVector moveVector;
      MapObject mapObject;

      // 1マスずつ進みながらチェック
      if (t + 1 <= int(speed))
        moveDistance = 1;
      else
        moveDistance = speed - t;

      // 進みたい方向に進んでみる
      moveVector = getDirectionVector(aimDirection);
      moveVector.mult(moveDistance);
      result.add(moveVector);

      mapObject = map.getObject(PVector.add(position, result));
      if (mapObject != MapObject.Wall && (status == MonsterStatus.Release || status == MonsterStatus.Return || mapObject != MapObject.MonsterDoor)) {
        turnFlag = true;
      } else {
        result.sub(moveVector);

        if (turnFlag)
          break;

        // 壁があったら直進する
        moveVector = getDirectionVector(direction);
        moveVector.mult(moveDistance);
        result.add(moveVector);

        mapObject = map.getObject(PVector.add(position, result));
        if (mapObject == MapObject.Wall || (status != MonsterStatus.Release && status != MonsterStatus.Return && mapObject == MapObject.MonsterDoor))
          break;
      }
    }

    if (turnFlag)
      return result;
    else
      return new PVector(0, 0);
  }

  // 目標地点に進むための方向を返す
  protected int getAimDirection(Map map, PVector point) {
    int aimDirection = 0;
    float distanceMin = map.size.mag();

    for (int i = 0; i < 4; i++) {
      // 各方向に進んだときに目標地点との距離が最短となる方向を探す
      int checkDirection = (direction + i) % 4;
      PVector checkMove = canMove(map, checkDirection);

      if (checkMove.mag() != 0 && PVector.add(position, checkMove).dist(point) < distanceMin) {
        aimDirection = checkDirection;
        distanceMin = PVector.add(position, checkMove).dist(point);
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
      if (canMove(stage.map, direction).mag() == 0)
        nextDirection = (direction + 2) % 4;
      break;

    case Release:
      // 出撃中は出撃地点を目指す
      aimPoint = stage.map.getReleasePoint();
      nextDirection = getAimDirection(stage.map, aimPoint);
      break;

    case Active:
      if (mode == MonsterMode.Ijike) {
        // イジケ中はランダムに動く
        aimPoint = new PVector(position.x + random(-1, 1), position.y + random(-1, 1));
        nextDirection = getAimDirection(stage.map, aimPoint);
      }
      break;

    case Return:
      break;
    }
  }

  // リセット
  public void reset() {
    super.reset();
    setStatus(MonsterStatus.Wait);
    setMode(MonsterMode.Rest);
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
      }
      break;

    default:
      break;
    }

    // アニメーションを更新
    if (canMove(map, direction).mag() != 0) {
      switch (status) {
      case Wait:
      case Release:
      case Active:
        if (mode == MonsterMode.Ijike) {
          ijikeAnimations[ijikeStatus].update();
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
        image(ijikeAnimations[ijikeStatus].getImage(), minPostision.x, minPostision.y);
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
