// グズタ
public class Guzuta extends Monster {
  public Guzuta(PVector position, int direction, float speed, int interval, String characterName) {
    super(position, direction, speed, interval, characterName);
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

    case Rest:
      // 休息中は左下を徘徊
      aimPoint = new PVector(random(0, stage.map.size.x / 2), random(stage.map.size.y / 2, stage.map.size.y));
      direction = getAimDirection(stage.map, aimPoint);
      break;

    case Chase:
      /* ――――――――――――――――――――――――――
         パックマンから半径260px外ではアカベイと同じ追跡方法、
         半径260px内ではランダムに動く
         ―――――――――――――――――――――――――― */
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
    }
  }
}
